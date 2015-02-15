class powerdns (
  $package                            = $::powerdns::params::package,
  $package_version                    = $::powerdns::params::package_version,
  $service                            = $::powerdns::params::service,
  $service_enable                     = $::powerdns::params::service_enable,
  $config_file                        = $::powerdns::params::config_file,
  $allow_axfr_ips                     = $::powerdns::params::allow_axfr_ips,
  $allow_recursion                    = $::powerdns::params::allow_recursion,
  $allow_recursion_override           = $::powerdns::params::allow_recursion_override,
  $cache_ttl                          = $::powerdns::params::cache_ttl,
  $chroot                             = $::powerdns::params::chroot,
  $config_dir                         = $::powerdns::params::config_dir,
  $config_name                        = $::powerdns::params::config_name,
  $daemon                             = $::powerdns::params::daemon,
  $default_soa_name                   = $::powerdns::params::default_soa_name,
  $disable_axfr                       = $::powerdns::params::disable_axfr,
  $disable_tcp                        = $::powerdns::params::disable_tcp,
  $distributor_threads                = $::powerdns::params::distributor_threads,
  $guardian                           = $::powerdns::params::guardian,
  $launch                             = $::powerdns::params::launch,
  $lazy_recursion                     = $::powerdns::params::lazy_recursion,
  $local_address                      = $::powerdns::params::local_address,
  $local_ipv6                         = $::powerdns::params::local_ipv6,
  $local_port                         = $::powerdns::params::local_port,
  $log_dns_details                    = $::powerdns::params::log_dns_details,
  $log_failed_updates                 = $::powerdns::params::log_failed_updates,
  $logfile                            = $::powerdns::params::logfile,
  $logging_facility                   = $::powerdns::params::logging_facility,
  $log_level                          = $::powerdns::params::log_level,
  $master                             = $::powerdns::params::master,
  $max_queue_length                   = $::powerdns::params::max_queue_length,
  $max_tcp_connections                = $::powerdns::params::max_tcp_connections,
  $module_dir                         = $::powerdns::params::module_dir,
  $negquery_cache_ttl                 = $::powerdns::params::negquery_cache_ttl,
  $out_of_zone_additional_processing  = $::powerdns::params::out_of_zone_additional_processing,
  $query_cache_ttl                    = $::powerdns::params::query_cache_ttl,
  $query_logging                      = $::powerdns::params::query_logging,
  $queue_limit                        = $::powerdns::params::queue_limit,
  $query_local_address                = $::powerdns::params::query_local_address,
  $receiver_threads                   = $::powerdns::params::receiver_threads,
  $recursive_cache_ttl                = $::powerdns::params::recursive_cache_ttl,
  $recursor                           = $::powerdns::params::recursor,
  $setgid                             = $::powerdns::params::setgid,
  $setuid                             = $::powerdns::params::setuid,
  $skip_cname                         = $::powerdns::params::skip_cname,
  $slave                              = $::powerdns::params::slave,
  $slave_cycle_interval               = $::powerdns::params::slave_cycle_interval,
  $soa_minimum_ttl                    = $::powerdns::params::soa_minimum_ttl,
  $soa_refresh_default                = $::powerdns::params::soa_refresh_default,
  $soa_retry_default                  = $::powerdns::params::soa_retry_default,
  $soa_expire_default                 = $::powerdns::params::soa_expire_default,
  $soa_serial_offset                  = $::powerdns::params::soa_serial_offset,
  $socket_dir                         = $::powerdns::params::socket_dir,
  $strict_rfc_axfrs                   = $::powerdns::params::strict_rfc_axfrs,
  $use_logfile                        = $::powerdns::params::use_logfile,
  $webserver                          = $::powerdns::params::webserver,
  $webserver_address                  = $::powerdns::params::webserver_address,
  $webserver_password                 = $::powerdns::params::webserver_password,
  $webserver_port                     = $::powerdns::params::webserver_port,
  $webserver_print_arguments          = $::powerdns::params::webserver_print_arguments,
  $version_string                     = $::powerdns::params::version_string,
  $pdns_d                             = $::powerdns::params::pdns_d,
  $pdns_d_purge                       = $::powerdns::params::pdns_d_purge,
) inherits powerdns::params {

  validate_array($allow_axfr_ips)
  validate_array($allow_recursion)
  validate_re($version_string, '^(anonymous|powerdns|full|custom)$')

  package { $package: ensure => $package_version, }

  file { $pdns_d:
    ensure  => directory,
    owner   => $setuid,
    group   => $setgid,
    mode    => '0700',
    recurse => $pdns_d_purge,
    purge   => $pdns_d_purge,
  }

  file { $config_file:
    ensure  => present,
    owner   => $setuid,
    group   => $setgid,
    mode    => '0600',
    content => template('powerdns/pdns.conf.erb'),
  }

  service { $service:
    ensure     => $service_enable,
    enable     => $service_enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File[$config_file],
  }

  Package[$package] ->
  File[$config_file] ->
  Service[$service]
}
