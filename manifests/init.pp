class route53me (
    $aws_access_key_id,
    $aws_secret_access_key,
    $aws_zone_id,
  ) {

  package { 'boto':
    ensure => '2.8.0',
    provider => pip,
  }

  file { "/usr/local/bin/route53me":
    owner => 'root',
    group => 'root',
    mode => '0700',
    content => template('route53me/route53me.erb'),
    require => Package['boto'],
  }

  rclocal::script { "update_route53":
    priority => "10",
    content  => "/usr/local/bin/route53me",
    require => File["/usr/local/bin/route53me"],
  }
}
