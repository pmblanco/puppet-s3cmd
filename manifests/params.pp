class s3cmd::params {

case $::lsbdistid {
    'Ubuntu','Debian' : {
        $package = 's3cmd'
    }
    default: { fail("Unsupported osfamily: ${::osfamily}") }
 }
}
