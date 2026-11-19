-- National Pharmaceutical Supply Chain: reusable KPI queries
-- Adapt table names/types to PostgreSQL, MySQL or SQL Server.

-- 1. National inventory snapshot
SELECT
    COUNT(*) AS stock_records,
    COUNT(DISTINCT product_id) AS products_in_stock,
    COUNT(DISTINCT facility_id) AS facilities,
    SUM(available_qty * unit_price_xof) AS available_stock_value_xof,
    100.0 * SUM(CASE WHEN available_qty > 0 THEN 1 ELSE 0 END) / COUNT(*) AS availability_pct,
    SUM(CASE WHEN available_qty = 0 THEN 1 ELSE 0 END) AS stockout_lines,
    SUM(CASE WHEN available_qty > 0 AND available_qty < minimum_stock_qty THEN 1 ELSE 0 END) AS low_stock_lines,
    SUM(CASE WHEN available_qty > maximum_stock_qty THEN 1 ELSE 0 END) AS overstock_lines,
    AVG(NULLIF(months_of_stock, 0)) AS average_mos_excluding_zero
FROM stock_data;

-- 2. Risk by region
SELECT region,
       COUNT(*) AS stock_lines,
       SUM(CASE WHEN available_qty = 0 THEN 1 ELSE 0 END) AS stockout_lines,
       SUM(CASE WHEN available_qty > 0 AND available_qty < minimum_stock_qty THEN 1 ELSE 0 END) AS low_stock_lines,
       SUM(available_qty * unit_price_xof) AS stock_value_xof
FROM stock_data
GROUP BY region
ORDER BY stockout_lines DESC;

-- 3. Product risk: stock-out and low-stock exposure
SELECT product_id, product_name,
       SUM(CASE WHEN available_qty = 0 THEN 1 ELSE 0 END) AS stockout_facilities,
       SUM(CASE WHEN available_qty > 0 AND available_qty < minimum_stock_qty THEN 1 ELSE 0 END) AS low_stock_facilities
FROM stock_data
GROUP BY product_id, product_name
HAVING SUM(CASE WHEN available_qty = 0 THEN 1 ELSE 0 END) > 0
    OR SUM(CASE WHEN available_qty > 0 AND available_qty < minimum_stock_qty THEN 1 ELSE 0 END) > 0
ORDER BY stockout_facilities DESC, low_stock_facilities DESC;

-- 4. Procurement performance
SELECT
    100.0 * SUM(delivered_qty) / NULLIF(SUM(ordered_qty), 0) AS order_fill_rate_pct,
    SUM(outstanding_qty) AS total_outstanding_qty,
    SUM(CASE WHEN order_status = 'Delivered'
              AND actual_delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) AS delivered_on_time_orders,
    SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders
FROM supply_orders;

-- 5. Open overdue orders (exclude cancelled and delivered)
SELECT order_id, supplier_name, destination_facility_id, product_id,
       expected_delivery_date, outstanding_qty, order_status
FROM supply_orders
WHERE order_status NOT IN ('Delivered', 'Cancelled')
  AND expected_delivery_date < DATE '2026-10-31'
ORDER BY expected_delivery_date, outstanding_qty DESC;

-- 6. FEFO / expiry exposure
SELECT batch_status, fefo_priority,
       COUNT(*) AS lots,
       SUM(batch_qty_remaining) AS remaining_qty
FROM expiry_tracking
GROUP BY batch_status, fefo_priority
ORDER BY batch_status, fefo_priority;

-- 7. Monthly reporting quality
SELECT reporting_status, COUNT(*) AS records
FROM consumption
GROUP BY reporting_status
ORDER BY records DESC;
