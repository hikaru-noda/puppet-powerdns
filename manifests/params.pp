class powerdns::params {
  $package          = 'pdns-server'
  $service          = 'pdns'
  $default_soa_name = 'a.misconfigured.powerdns.server'
  $config_dir       = '/etc/powerdns'
  $config_file      = "${config_dir}/pdns.conf"
  $module_dir       = '/usr/lib/powerdns'
  $user             = 'pdns'
  $group            = 'pdns'
  $socket_dir       = '/var/run'
  $pdns_d           = '/etc/powerdns/pdns.d'
}
