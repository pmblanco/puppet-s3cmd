class s3cmd::params {

case $::lsbdistid {
    'Ubuntu','Debian' : {
        $packages = ['s3cmd','python-magic']
    }
    default: { fail("Unsupported OS: ${::lsbdistid}") }
 }
}
