class powerdns::recursor {

  package { $::powerdns::recursor_package:
    ensure  => $::powerdns::package_version,
  }

  file { $::powerdns::recursor_config_file:
    ensure  => present,
    owner   => $::powerdns::setuid,
    group   => $::powerdns::setgid,
    mode    => '0600',
    content => template("${module_name}/recursor.conf.erb"),
  }

  service { $::powerdns::recursor_service:
    ensure     => $::powerdns::service_enable,
    enable     => $::powerdns::service_enable,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File[$::powerdns::recursor_config_file],
  }

  Package[$::powerdns::recursor_package] ->
  File[$::powerdns::recursor_config_file] ->
  Service[$::powerdns::recursor_service]

}
