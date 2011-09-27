name "magento-database"
description "Magento database server using mySQL 5.x. This is a database server with the Magento database setup and mySQL tuned to the needs of Magento"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "magento::mysql"
  )
# Attributes applied if the node doesn't have it set already.
default_attributes "mysql" => {
    "tunable" => {
        "max_connections" => "1000",
        "max_connect_errors" => "10",
        "table_cache" => "1024",
        "max_allowed_packet" => "16M",
        "max_heap_table_size" => "64M",
        "sort_buffer_size" => "8M",
        "join_buffer_size" => "8M",
        "thread_cache_size" => "8",
        "thread_concurrency" => "8",
        "query_cache_size" => "64M",
        "query_cache_limit" => "2M",
        "tmp_table_size" => "64M",
        "key_buffer_size" => "32M",
        "read_buffer_size" => "2M",
        "read_rnd_buffer_size" => "16M",
        "bulk_insert_buffer_size" => "64M",
        "myisam_sort_buffer_size" => "128M",
        "myisam_max_sort_file_size" => "10G",
        "myisam_repair_threads" => "1",
        "innodb_additional_mem_pool_size" => "16M",
        "innodb_log_buffer_size" => "8M",
        "innodb_log_file_size" => "512M",
        "innodb_buffer_pool_size" => "10G",
        "innodb_autoextend_increment" => "512"
    }
}
# Attributes applied no matter what the node has set already.
override_attributes()