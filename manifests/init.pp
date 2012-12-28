class powerdns (
  $package                           = $::powerdns::params::package,
  $package_version                   = 'installed',
  $service                           = $::powerdns::params::service,
  $service_enable                    = true,
  $config_file                       = $::powerdns::params::config_file,
  $allow_axfr_ips                    = [],
  $allow_recursion                   = ['127.0.0.1'],
  $allow_recursion_override          = false,
  $cache_ttl                         = '20',
  $chroot                            = undef,
  $config_dir                        = $::powerdns::params::config_dir,
  $config_name                       = undef,
  $daemon                            = true,
  $default_soa_name                  = $::powerdns::params::default_soa_name,
  $disable_axfr                      = true,
  $disable_tcp                       = false,
  $distributor_threads               = '3',
  $guardian                          = true,
  $launch                            = [],
  $lazy_recursion                    = true,
  $local_address                     = '0.0.0.0',
  $local_ipv6                        = undef,
  $local_port                        = '53',
  $log_dns_details                   = true,
  $log_failed_updates                = true,
  $logfile                           = undef,
  $logging_facility                  = undef,
  $log_level                         = '4',
  $master                            = false,
  $max_queue_length                  = '5000',
  $max_tcp_connections               = '10',
  $module_dir                        = $::powerdns::params::module_dir,
  $negquery_cache_ttl                = '60',
  $out_of_zone_additional_processing = false,
  $query_cache_ttl                   = '20',
  $query_logging                     = false,
  $queue_limit                       = '1500',
  $query_local_address               = undef,
  $receiver_threads                  = '1',
  $recursive_cache_ttl               = '10',
  $recursor                          = undef,
  $setgid                            = $::powerdns::params::group,
  $setuid                            = $::powerdns::params::user,
  $skip_cname                        = false,
  $slave                             = false,
  $slave_cycle_interval              = '60',
  $soa_minimum_ttl                   = '3600',
  $soa_refresh_default               = '10800',
  $soa_retry_default                 = '3600',
  $soa_expire_default                = '604800',
  $soa_serial_offset                 = '0',
  $socket_dir                        = $::powerdns::params::socket_dir,
  $strict_rfc_axfrs                  = false,
  $use_logfile                       = true,
  $webserver                         = false,
  $webserver_address                 = '127.0.0.1',
  $webserver_password                = undef,
  $webserver_port                    = '8081',
  $webserver_print_arguments         = false,
  $version_string                    = 'powerdns',
  $pdns_d                            = $::powerdns::params::pdns_d,
  $pdns_d_purge                      = false
) inherits powerdns::params {

  validate_array($allow_axfr_ips)
  validate_array($allow_recursion)
  validate_re($version_string, '^(anonymous|powerdns|full|custom)$')

  package { $package: ensure => $package_version, }

  file { $pdns_d:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    recurse => $pdns_d_purge,
    purge   => $pdns_d_purge,
  }

  file { $config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
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
