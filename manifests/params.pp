class s3cmd::params {

  case $::osfamily {
    'Debian','RedHat' : {
      $packages = ['s3cmd','python-magic']
    }
    default: { fail("Unsupported OS: ${::lsbdistid}") }
  }
}
