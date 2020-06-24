view: orders {
  sql_table_name: looker-test-db.looker_test.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }

  dimension: created {
#     type: date_raw
   sql:date_add((CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', ${TABLE}.created_at , 'America/Chicago')) AS DATE)),INTERVAL 7 YEAR) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }
}
