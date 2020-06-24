connection: "thelook"

# include all the views
include: "/views/**/*.view"
include: "//exchange_rate_block_test/*.view"

datagroup: ecommerce_sindhu_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ecommerce_sindhu_default_datagroup

explore: connection_reg_r3 {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

explore: flights {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

# explore: order_blocks {
#   from: orders
#   join: bq_forex{
#     type: left_outer
#     sql_on: ${order_blocks.created} = ${bq_forex.exchange_date} ;;
#     relationship: many_to_one
#   }
#   join: order_items {
#     sql_on: ${order_items.order_id}=${order_blocks.id} ;;
#   }
#   join: bq_forex_historical_real {
#     sql_on: ${bq_forex_historical_real.forex_exchange_date}=${order_blocks.created} ;;
#   }
#   join: bq_forex_real {
#     sql_on: ${bq_forex_real.exchange_date}=${order_blocks.created} ;;
#   }
# }

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }
}

explore: users {}
