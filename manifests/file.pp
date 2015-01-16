define s3cmd::file (
  
  $source,
  $ensure    = 'latest',
  $tries     = 3,
  $try_sleep = 1,
  $cfg       = '/root/.s3cfg',
  $owner     = 'root',
  $group     = 'root',
  $mode      = '600',
  $recurse   = false,
  $target    = $name

) {

  include s3cmd::params

  validate_bool($recurse)

  if $recurse == true {
    $cmd = 'sync'
  } else {
    $cmd = 'get'
  }

  $valid_ensures = [ 'absent', 'present', 'latest' ]
  validate_re($ensure, $valid_ensures)

  if $ensure == 'absent' {

        file { $name: }
  } else {
    
    if $ensure == 'latest' {
      $onlyif = "[ ! -e ${name} ] || s3cmd -c $cfg --no-progress --dry-run $cmd ${source} ${target} 2>&1 |grep -iq ${name}"
      $force = '--force'
    } else {
      $onlyif = "[ ! -e ${name} ]"
    }
    
    exec { "fetch ${name}": 
      path      => ['/bin', '/usr/bin', 'sbin', '/usr/sbin'],
      command   => "s3cmd -c $cfg --no-progress $cmd $force ${source} ${target}",
      logoutput => 'on_failure',
      tries     => $tries,
      try_sleep => $try_sleep ,
      onlyif    => $onlyif,
      require   => Package[$s3cmd::params::packages],
    }->
    file { $name: 
      mode  => $mode,
      owner => "$owner",
      group => "$group",
    }
  }
}
