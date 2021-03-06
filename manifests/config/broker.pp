# Create a Shinken Module
define shinken::config::broker (
  $ensure   = 'present',
  $options  = {},
) {
  validate_hash($options)
  $merged_options = merge($shinken::defaults::broker_options,$options)

  file { "${::shinken::config_path}/brokers/${name}.cfg":
    ensure  => $ensure,
    mode    => '0444',
    owner   => 'shinken',
    content => template('shinken/config.cfg.erb'),
    notify  => Class['::shinken::service'],
  }

}
