class powerdns::params {
  $allow_axfr_ips                     = []
  $allow_recursion                    = ['127.0.0.1']
  $cache_ttl                          = '20'
  $chroot                             = undef
  $config_dir                         = '/etc/pdns'
  $config_file                        = "${config_dir}/pdns.conf"
  $config_name                        = undef
  $daemon                             = true
  $default_soa_name                   = 'a.misconfigured.powerdns.server'
  $disable_axfr                       = true
  $disable_tcp                        = false
  $distributor_threads                = '3'
  $guardian                           = true
  $launch                             = ['bind:static']
  $local_address                      = $::ipaddress
  $local_ipv6                         = undef
  $local_port                         = '53'
  $log_dns_details                    = false
  $log_failed_updates                 = false
  $logging_facility                   = undef
  $log_level                          = '5'
  $master                             = false
  $max_queue_length                   = '5000'
  $max_tcp_connections                = '10'
  $module_dir                         = '/usr/lib64/pdns'
  $named_conf			      = "${config_dir}/named.conf"
  $negquery_cache_ttl                 = '60'
  $out_of_zone_additional_processing  = false
  $package                            = 'pdns'
  $package_version                    = 'installed'
  $query_cache_ttl                    = '20'
  $query_logging                      = false
  $queue_limit                        = '1500'
  $query_local_address                = undef
  $receiver_threads                   = '1'
  $recursive_cache_ttl                = '10'
  $recursor                           = undef
  $recursor_config_file		      = "${config_dir}/recursor.conf"
  $recursor_package		      =	'pdns-recursor'
  $recursor_service		      = 'pdns-recursor'
  $service                            = 'pdns'
  $service_enable                     = true
  $setgid                             = 'pdns'
  $setuid                             = 'pdns'
  $slave                              = false
  $slave_cycle_interval               = '60'
  $soa_minimum_ttl                    = '3600'
  $soa_refresh_default                = '10800'
  $soa_retry_default                  = '3600'
  $soa_expire_default                 = '604800'
  $soa_serial_offset                  = '0'
  $socket_dir                         = '/var/run'
  $webserver                          = false
  $webserver_address                  = '127.0.0.1'
  $webserver_password                 = undef
  $webserver_port                     = '8081'
  $webserver_print_arguments          = false
  $version_string                     = 'powerdns'
  $zone_dir			      = "${config_dir}/zones"
}
