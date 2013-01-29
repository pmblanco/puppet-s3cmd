define s3cmd::file ($source, $ensure = 'latest', $bucket_location = 'eu-west-1',$path = '/root/.s3cfg', $tries = 3, $try_sleep = 1, cfg='/root/.s3cfg', $owner='root', group='root', $mode='600')  {
    include s3cmd::params

    $valid_ensures = [ 'absent', 'present', 'latest' ]
    validate_re($ensure, $valid_ensures)

    if $ensure == 'absent' {
        file { $name:
        }
    } else {
        $real_source = "s3://${bucket_location}s.s3.amazonaws.com/${source}"

        # We need to double the code as there is no way to check via s3cmd if the file has changed. I mean if we check it we might as well just pull it off. 
        if ensure == 'latest' {
            unless => "[ -e ${name} ] && s3cmd --no-progress --dry-run sync ${real_source} ${name} 2>&1 |grep -iq ${name}"
        } else {
            unless => "[ -e ${name} ]"
        
        }
    exec { "fetch {$name}": 
                path => ['/bin', '/usr/bin', 'sbin', '/usr/sbin'],
                command => "s3cmd --no-progress sync ${real_source} ${name}",
                logoutput => 'on_failure',
                tries => $tries,
                try_sleep => $try_sleep ,
                unless => $unless,
                require => Package["$s3cmd::params::package"];
     }
     -> file { $name: 
            mode  => $mode,
            owner => 'root',
            grou  => 'root',
     }

    }
}
