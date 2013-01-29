class s3cmd inherits s3cmd::params {
    package { ["$s3cmd::params::package",'python-magic']:  ensure => installed }
}
