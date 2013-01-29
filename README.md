puppet-s3cmd
============

Puppet's s3cmd configuration module. Specify different config files and set of auth credentials.

s3cmd::file part is based on https://github.com/branan/puppet-module-s3file

Usage:

   s3cmd {'s3cfg_main': s3aid => "$generalsettings::backup_s3_aid", s3key => "$generalsettings::backup_s3_key" ;}

