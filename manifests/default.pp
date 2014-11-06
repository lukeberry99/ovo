exec { "apt-get update":
    path => "/usr/bin",
}
package { "apache2":
    ensure => present,
    require => Exec["apt-get update"],
}
service { "apache2":
    ensure => "running",
    require => Package["apache2"],
}
package { 'mysql-server': 
    require => Exec["apt-get update"],
    ensure => present,
}
service { 'mysql':
    ensure => running,
    require => Package["mysql-server"],
}
package { "php5":
    require => Exec["apt-get update"],
    ensure => installed,
}

file { "/var/www/ovo":
    ensure => "link",
    target => "/vagrant/ovo",
    require => Package["apache2"],
    notify => Service["apache2"],
}

