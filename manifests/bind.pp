class powerdns::bind (
  $purge_zone_dir = true
) {

  include powerdns

  File {
    owner   => $::powerdns::setuid,
    group   => $::powerdns::setuid,
    mode    => '0644',
    require => File[$::powerdns::config_file],
    notify  => Service[$::powerdns::service],
  }

  file { $::powerdns::zone_dir:
    ensure  => directory,
    mode    => '0755',
    recurse => $purge_zone_dir,
    purge   => $purge_zone_dir,
  }

  concat { $::powerdns::named_conf:
    ensure          => present,
    ensure_newline  => true,
  }

}
