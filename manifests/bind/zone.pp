define powerdns::bind::zone (
  $source,
) {

  include powerdns::bind

  file { "${::powerdns::bind::zone_dir}/db.${name}":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => $source,
    notify => Service[$::powerdns::service],
  }
}
