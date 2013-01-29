puppet-s3cmd
============

Puppet's s3cmd configuration module. Specify different config files and set of auth credentials.

s3cmd::file part is based on https://github.com/branan/puppet-module-s3file

This should basically work as a replacement for file supporting options like: 
* ensure
* recurse
* group
* owner
* mode

For full spec please look into particular files.
Any improvements or feedback very much welcomed.


Usage:

```
include s3cmd

s3cmd::config {'s3cfg_main': s3aid => "_ID_", s3key => "_KEY_", bucket_location => 'eu-west-1' ;}
s3cmd::file {'/tmp/test.sh':
    source => 's3://bucket/files/test.sh'
}

# Via s3cmd: "Destination must be a directory or stdout when downloading multiple sources." Basically we need trailing slash at the end of destination.
# Also the target directory needs to exist, it is not created automatically.
# It works very similiar like rsync with trailing slashes at the source.
# Be ware of https://github.com/s3tools/s3cmd/issues/106

s3cmd::file {'/tmp/test/':
    source => 's3://bucket/tmp/test',
    recurse => true,
    ensure => latest,
}
```
