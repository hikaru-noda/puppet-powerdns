class powerdns (
  $allow_axfr_ips                     = $::powerdns::params::allow_axfr_ips,
  $allow_recursion                    = $::powerdns::params::allow_recursion,
  $cache_ttl                          = $::powerdns::params::cache_ttl,
  $chroot                             = $::powerdns::params::chroot,
  $config_dir                         = $::powerdns::params::config_dir,
  $config_file                        = $::powerdns::params::config_file,
  $config_name                        = $::powerdns::params::config_name,
  $daemon                             = $::powerdns::params::daemon,
  $default_soa_name                   = $::powerdns::params::default_soa_name,
  $disable_axfr                       = $::powerdns::params::disable_axfr,
  $disable_tcp                        = $::powerdns::params::disable_tcp,
  $distributor_threads                = $::powerdns::params::distributor_threads,
  $guardian                           = $::powerdns::params::guardian,
  $launch                             = $::powerdns::params::launch,
  $local_address                      = $::powerdns::params::local_address,
  $local_ipv6                         = $::powerdns::params::local_ipv6,
  $local_port                         = $::powerdns::params::local_port,
  $log_dns_details                    = $::powerdns::params::log_dns_details,
  $log_failed_updates                 = $::powerdns::params::log_failed_updates,
  $logging_facility                   = $::powerdns::params::logging_facility,
  $log_level                          = $::powerdns::params::log_level,
  $master                             = $::powerdns::params::master,
  $max_queue_length                   = $::powerdns::params::max_queue_length,
  $max_tcp_connections                = $::powerdns::params::max_tcp_connections,
  $module_dir                         = $::powerdns::params::module_dir,
  $named_conf			      = $::powerdns::params::named_conf,
  $negquery_cache_ttl                 = $::powerdns::params::negquery_cache_ttl,
  $out_of_zone_additional_processing  = $::powerdns::params::out_of_zone_additional_processing,
  $package                            = $::powerdns::params::package,
  $package_version                    = $::powerdns::params::package_version,
  $query_cache_ttl                    = $::powerdns::params::query_cache_ttl,
  $query_logging                      = $::powerdns::params::query_logging,
  $queue_limit                        = $::powerdns::params::queue_limit,
  $query_local_address                = $::powerdns::params::query_local_address,
  $receiver_threads                   = $::powerdns::params::receiver_threads,
  $recursive_cache_ttl                = $::powerdns::params::recursive_cache_ttl,
  $recursor                           = $::powerdns::params::recursor,
  $recursor_config_file               = $::powerdns::params::recursor_config_file,
  $recursor_package                   = $::powerdns::params::recursor_package,
  $recursor_service                   = $::powerdns::params::recursor_service,
  $service                            = $::powerdns::params::service,
  $service_enable                     = $::powerdns::params::service_enable,
  $setgid                             = $::powerdns::params::setgid,
  $setuid                             = $::powerdns::params::setuid,
  $slave                              = $::powerdns::params::slave,
  $slave_cycle_interval               = $::powerdns::params::slave_cycle_interval,
  $soa_minimum_ttl                    = $::powerdns::params::soa_minimum_ttl,
  $soa_refresh_default                = $::powerdns::params::soa_refresh_default,
  $soa_retry_default                  = $::powerdns::params::soa_retry_default,
  $soa_expire_default                 = $::powerdns::params::soa_expire_default,
  $soa_serial_offset                  = $::powerdns::params::soa_serial_offset,
  $socket_dir                         = $::powerdns::params::socket_dir,
  $webserver                          = $::powerdns::params::webserver,
  $webserver_address                  = $::powerdns::params::webserver_address,
  $webserver_password                 = $::powerdns::params::webserver_password,
  $webserver_port                     = $::powerdns::params::webserver_port,
  $webserver_print_arguments          = $::powerdns::params::webserver_print_arguments,
  $version_string                     = $::powerdns::params::version_string,
  $zone_dir			      = $::powerdns::params::zone_dir
) inherits powerdns::params {

  validate_array($::powerdns::allow_axfr_ips)
  validate_array($::powerdns::allow_recursion)
  validate_re($::powerdns::version_string, '^(anonymous|powerdns|full|custom)$')

  package { $::powerdns::package: ensure => $::powerdns::package_version, }

  file { $::powerdns::config_dir:
    ensure  => directory,
    owner   => $::powerdns::setuid,
    group   => $::powerdns::setgid,
    mode    => '0700',
    recurse => $::powerdns::pdns_d_purge,
    purge   => $::powerdns::pdns_d_purge,
  } ->

  file { $::powerdns::config_file:
    ensure  => present,
    owner   => $::powerdns::setuid,
    group   => $::powerdns::setgid,
    mode    => '0600',
    content => template("${module_name}/pdns.conf.erb"),
  }

  service { $::powerdns::service:
    ensure     => $::powerdns::service_enable,
    enable     => $::powerdns::service_enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File[$::powerdns::config_file],
  }

  if $recursor {
    include powerdns::recursor
  }

  Package[$::powerdns::package] ->
  File[$::powerdns::config_file] ->
  Service[$::powerdns::service]
}
