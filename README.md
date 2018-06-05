WWSd
====

Workspace Wallpaper Setter
--------------------------

i3wm Workspace wallpaper setter python script: given a rule in config file, changes the wallpaper for each display.

Uses i3-msg to get the currently displayed workspaces, then uses a rule specified in a config file to set the wallpaper.

Depends:
 - `i3wm` : what this was made for
 - `nitrogen` : used to set wallpapers
 - [`docopt`](https://github.com/docopt/docopt) : (python package) for easy commandline options

Shouldn't have too big of a performance hit (although it does sit at ~1% CPU on both of the [i7] machines I've tested it on). If it does become an issue, I'm thinking about re-writing in `c` using something like `libi3ipc` for the i3 interoperability. 
 
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
  -r --restart                   Kills any previous forked processes, starts new watcher process
  -c --config=<config>           Override default config file
  -s --sleep-time=<sleep-time>   Override default downtime between checks [default: 0.1].
  -g --generate-config           Generates a new config file
  -k --kill-fork                 Kills forked process
```

Configuration
-------------
### Rules
The config file is looked for in $HOME/.config/wwsd/config.json by default, this can be overridden by using the commandline option `--config-file=<config-file>`. Config file is a JSON file (sort of: it will be evaluated by python, so it is python, but its easier to refer to it as JSON). Rules specify which parameter (from the result of `i3-msg -t get_workspaces`) to use to decide the wallpaper.

Valid parameters are:

 - `num` (int)
 - `name` (str)
 - `visible` (bool)
 - `focused` (bool)
 - `output` (str)
 - `urgent` (bool)
 
Rules are a dictionary where the keys are the parameter to use, and the values are lists of parameter-values and wallpapers. If the rule is not specified, a default value is used.

Example config.json:

```javascript
{
	'rules' : {
		'num'    : [1,        '/path/to/wallpaper_A.jpg'],
		'num'    : [2,        '/path/to/wallpaper_B.jpg'],
		'output' : ['HDMI-2', '/path/to/wallpaper_C.jpg']
	},
	'default' : '/path/to/default/wallpaper.jpg'
}
```

In the above, workspaces indexed 1 and 2 are individually set wallpapers A and B respectively, all of the workspaces on output 'HDMI-2' are set wallpaper C, and the rest of the workspaces are set a default.

### Display indexing
Multiple displays are supported in nitrogen, and so they are here. By default, the displayes are indexed according to their order from `xrandr -q`, but if this is not correct for some reason it can be overridden by adding a dictionary object to the config:

```javascript
'display_indexing' : {
	'HDMI-1' : 1, // whatever your output is called, corresponding to a 0-based index
	'HDMI-2' : 0  // in xrandr, these displays would be swapped.
}
```

TODO
----
 - Add interop with other parts of i3-msg. `get_tree` especially could be cool; different wallpapers depending on the current active application or something
 - Add config file generator/editor
 - Add install
