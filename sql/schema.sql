CREATE DATABASE e_commerce_db;

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    product_name TEXT NOT NULL,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT
);

CREATE TABLE website_sessions (
    website_session_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    user_id BIGINT,
    is_repeat_session BOOLEAN,
    utm_source TEXT,
    utm_campaign TEXT,
    utm_content TEXT,
    device_type TEXT,
    http_referer TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT
);

CREATE TABLE website_pageviews (
    website_pageview_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    website_session_id BIGINT NOT NULL,
    pageview_url TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT,
    CONSTRAINT fk_pageviews_sessions FOREIGN KEY (website_session_id) REFERENCES website_sessions(website_session_id)
);

CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    website_session_id BIGINT,
    user_id BIGINT,
    primary_product_id BIGINT,
    items_purchased INTEGER,
    price_usd NUMERIC(10,2),
    cogs_usd NUMERIC(10,2),
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT,
    CONSTRAINT fk_orders_sessions FOREIGN KEY (website_session_id) REFERENCES website_sessions(website_session_id),
    CONSTRAINT fk_orders_products FOREIGN KEY (primary_product_id) REFERENCES products(product_id)
);

CREATE TABLE order_items (
    order_item_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    is_primary_item BOOLEAN,
    price_usd NUMERIC(10,2),
    cogs_usd NUMERIC(10,2),
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT,
    CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE order_item_refunds (
    order_item_refund_id BIGINT PRIMARY KEY,
    created_at TIMESTAMP,
    order_item_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    refund_amount_usd NUMERIC(10,2),
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    day_name TEXT,
    CONSTRAINT fk_refunds_order_items FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id),
    CONSTRAINT fk_refunds_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);