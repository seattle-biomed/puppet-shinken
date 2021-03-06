# Create a Shinken Module
define shinken::config::object (
  $ensure       = 'present',
  $object_type  = undef,
  $options      = {},
  $object_path  = undef,
) {
  if $object_path {
    $resource_path = $object_path
  } else {
    $resource_path  = "${::shinken::config_path}/${object_type}s"
  }

  validate_absolute_path($resource_path)
  validate_hash($options)

  file { "${resource_path}/${name}.cfg":
    ensure  => $ensure,
    mode    => '0440',
    owner   => 'shinken',
    content => template('shinken/object.cfg.erb'),
    notify  => Class['::shinken::service'],
  }

}
