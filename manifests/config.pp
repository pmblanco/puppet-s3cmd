define s3cmd::config ($s3key = '', $s3aid = '', $bucket_location = 'eu-west-1', $path = '/root/.s3cfg')  {
    include s3cmd::params

    if ($s3key == '') {
        fail('Please specify s3key to access S3:')
    }
    if ($s3aid == '') {
        fail('Please specify s3aid to access S3')
    }

    file { "$path": 
        ensure => present,
        content => template('s3cmd/s3cmd.erb'),
        mode => '0600',
        require => Package["$s3cmd::params::package"];
    }
}
