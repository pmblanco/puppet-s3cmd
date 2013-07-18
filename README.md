puppet-s3cmd
============

Puppet's s3cmd configuration module. Specify different config files and set of auth credentials.

s3cmd::file part is based on https://github.com/branan/puppet-module-s3file

This should basically work as a more or less replacement for file supporting options like: 
* ensure
* recurse
* group
* owner
* mode


For full spec please look into particular files.

Any improvements or feedback very much welcomed.

## WARNING
Unfortunatelly s3cmd is not the most reliable tool to script around and there are lots of minor bugs and issues of which some pull requests have been made although not merged to the master branch, project seems a bit stalled at this time.

Almost in any case you should be using s3cmd's _sync_ instead of _get_ to synchronize directories even when downloading single file as only this scenario ensures that the files are downloaded only when necessary - avoiding s3 transfer cost. Keep in mind that md5sum need to be checked by s3cmd anyway which involves some s3 requests to be made.


Usage:

```
include s3cmd

s3cmd::config {'s3cfg_main':
    s3aid => "_ID_",
    s3key => "_KEY_",
    bucket_location => 'eu-west-1'
    # default path is /root/.s3cfg, you can specify custom path by
    # path => '/custom/path/.s3cfg'
}

# You could use this statement which would end up downloading file every time puppet runs
s3cmd::file {'/tmp/test.sh':
    source => 's3://bucket/files/test.sh'
}

# Or you could use _sync_ (recurs => true - makes use of s3cmd's sync) to make sure the transfer happens only when necessary
s3cmd::file {'/tmp/test.sh':
    source  => 's3://bucket/files/test.sh'
    recurse => true,
    target  => '/tmp/'
}

# Via s3cmd: "Destination must be a directory or stdout when downloading multiple sources." Basically we need trailing slash at the end of destination.
# Also the target directory needs to exist, it is not created automatically.
# It works very similiar like rsync with trailing slashes at the source.
# Be ware of https://github.com/s3tools/s3cmd/issues/106

# In the following example /tmp/test/ needs to exist as it won't be created
s3cmd::file {'/tmp/test/':
    source  => 's3://bucket/tmp/test/',
    recurse => true,
    ensure  => latest,
}

# In the following example /tmp needs to exist and /tmp/test will be created.
s3cmd::file {'/tmp/test':
    source  => 's3://bucket/tmp/test',
    target  => '/tmp/',
    recurse => true,
    ensure  => latest,
}

```
