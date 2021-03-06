class user_accounts {

	$root_password = hiera('accounts::users::root::password', '')

	if defined('ohmyzsh') {
		$require = [ Package['zsh'] ]
	} else {
		$require = undef
	}

	if $root_password != '' {
		user { 'root':
			password => $root_password,
			require  => $require,
		}
	}

	class { 'accounts':
		accounts   => hiera_hash('accounts::accounts', {}),
		ssh_keys   => hiera_hash('accounts::ssh_keys', {}),
		users      => hiera_hash('accounts::users', {}),
		groups     => hiera_hash('accounts::groups', {}),
	}

}
