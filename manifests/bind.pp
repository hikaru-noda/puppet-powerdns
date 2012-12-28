class powerdns::bind (
  $purge_zone_dir = true,
  $named_conf_template
) {

  include powerdns

  $named_conf = "${::powerdns::config_dir}/named.conf"
  $zone_dir   = "${::powerdns::config_dir}/zones"

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File[$::powerdns::config_file],
    notify  => Service[$::powerdns::service],
  }

  file { $zone_dir:
    ensure  => directory,
    mode    => '0755',
    recurse => $purge_zone_dir,
    purge   => $purge_zone_dir,
  }

  file { $named_conf:
    ensure  => present,
    content => template($named_conf_template),
  }

  file { "${::powerdns::pdns_d}/bind-config":
    ensure  => present,
    content => "bind-config=${named_conf}\n",
    require => File[$named_conf],
  }
}
