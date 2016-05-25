class nginx {
  yumrepo { 'base':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Base',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
    before     => [ Package['nginx'], Package['openssl-libs'] ],
  }
  
  yumrepo { 'updates':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Updates',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
    before     => [ Package['nginx'], Package['openssl-libs'] ],
  }
  
  yumrepo { 'extras':
    ensure              => 'present',
    descr               => 'CentOS-$releasever - Extras',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist          => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras&infra=$infra',
    priority            => '99',
    skip_if_unavailable => '1',
    before     => [ Package['nginx'], Package['openssl-libs'] ],
  }
  
  yumrepo { 'centosplus':
    ensure     => 'present',
    descr      => 'CentOS-$releasever - Plus',
    enabled    => '1',
    gpgcheck   => '1',
    gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus&infra=$infra',
    before     => [ Package['nginx'], Package['openssl-libs'] ],
  }

  package { [ 'openssl', 'openssl-libs' ] :
    ensure => '1.0.1e-51.el7_2.5',
    before => Package['nginx'],
  }

  file { 'nginx rpm' :
    ensure   => file,
    path     => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    source   => 'puppet:///modules/nginx/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
  }

  package { 'nginx' :
    ensure   => '1.6.2-1.el7.centos.ngx',
    source   => '/opt/nginx-1.6.2-1.el7.centos.ngx.x86_64.rpm',
    provider => rpm,
    require  => File['nginx rpm'],
  }
}
