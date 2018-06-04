wwsd
====

Workspace Wallpaper Setter
--------------------------

i3wm Workspace wallpaper setter python script: given a rule in config file, changes the wallpaper for each display.

Uses i3-msg to get the currently displayed workspaces, then uses a rule specified in a config file to set the wallpaper.

Depends:
 - `i3wm` : what this was made for
 - `nitrogen` : used to set wallpapers
 - [`docopt`](https://github.com/docopt/docopt) : (python package) for easy commandline options

Shouldn't have too big of a performance hit (although it does sit at ~1% on both of the [i7] machines I've tested it on). If it does become an issue, I'm thinking about re-writing in `c` using something like `libi3ipc` for the i3 interoperability. 
 
Usage
-----
```bash
Usage:
  wwsd (-h | --help)
  wwsd (--begin | --restart) [--config=<config>] [--sleep-time=<sleep-time>] [--generate-config] [--dont-fork]
  wwsd --generate-config [--config=<config>] 
  wwsd --kill-fork

Options:
  -h --help                      Show this message
  -b --begin                     Start the watcher process
  -r --restart                   Kills any previous forked processes, starts new watcher
  -c --config=<config>           Override default config file
  -s --sleep-time=<sleep-time>   Override default downtime between checks [default: 0.1].
  -g --generate-config           Generates a new config file
  -k --kill-fork                 Kills forked process
```

Configuration
-------------
### Rules
The config file is looked for in $HOME/.config/wwsd/config.json by default, this can be overridden by using the commandline option '--config-file=<config-file>'. Config file is a json file (sort of: it will be evaluated by python, so it is python, but its easier to refer to it as JSON). Rules specify which parameter (from the result of `i3-msg -t get_workspaces`) to use to decide the wallpaper.

Valid parameters are:

 - `num` (int)
 - `name` (str)
 - `visible` (bool)
 - `focused` (bool)
 - `output` (str)
 - `urgent` (bool)
 
Wallpapers for specific values of the desired param are given in the `'rule'` object. If the rule is not specified, a default value is used.

Example config.json:

```javascript
{
	'param' : 'num',
	'rules' : {
		0:'/path/to/a/wallpaper.jpg',
		1:'/path/to/a/wallpaper.jpg',
		2:'/path/to/a/wallpaper.jpg'// and so on...
	},
	'default' : '/path/to/default/wallpaper.jpg'
}
```

### Display indexing
Multiple displays are supported in nitrogen, and so they are here. Be default, the displayes are indexed according to their order from `xrandr -q`, but if this is not correct for some reason it can be overridden by adding an object to the config:

```javascript
{
	'param' : 'num',
	'rules' : {
		0:'/path/to/a/wallpaper.jpg',
		1:'/path/to/a/wallpaper.jpg',
		2:'/path/to/a/wallpaper.jpg'// and so on...
	},
	'default' : '/path/to/default/wallpaper.jpg',
	'display_indexing' : {
		'HDMI-1' : 1, // whatever your output is called, corresponding to a 0-based index
		'HDMI-2' : 0  // in xrandr, these displays would be swapped.
	}
}
```

TODO
----
 - Add config file generator/editor
 - Add install
