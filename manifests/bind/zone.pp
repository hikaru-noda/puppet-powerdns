define powerdns::bind::zone (
  $source
) {

  include powerdns::bind

  file { "${::powerdns::zone_dir}/${name}.zone":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => $source,
    notify => Service[$::powerdns::service],
  }

  concat::fragment{ "${name}_zone":
    target  => $::powerdns::named_conf,
    content => "zone \"${name}\" IN { type master; file \"/etc/pdns/zones/${name}.zone\"; };",
  }
}
