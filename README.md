WWSd
====

Workspace Wallpaper Setter
--------------------------

i3wm Workspace wallpaper setter python script: given a rule in config file, changes the wallpaper for each display.

When currently focussed workspace is changed, gets info about the currently displayed workspaces then uses a user-specified rule to set the wallpaper.

Depends:
 - [`i3wm`](https://github.com/i3/i3) : what this was made for
 - [`nitrogen`](https://github.com/l3ib/nitrogen) : used to set wallpapers
 - [`docopt`](https://github.com/docopt/docopt) : for easy commandline options
 - [`i3ipc-python`](https://github.com/acrisci/i3ipc-python) : for better i3 interoperability
 
Usage
-----
```bash
Usage:
  wwsd (-h | --help)
  wwsd (--begin | --restart) [--config=<config>] [--dont-fork]
  wwsd --generate-config [--config=<config>] 
  wwsd --kill-fork

Options:
  -h --help                      Show this message
  -b --begin                     Start the watcher process
  -r --restart                   Kills any previous forked processes, starts new watcher process
  -c --config=<config>           Override default config file
  -g --generate-config           Generates a new config file
  -k --kill-fork                 Kills forked process
  -d --dont-fork                 Does not fork to new process
```

Configuration
-------------
### Rules
The config file is looked for in `$HOME/.config/wwsd/config.json` by default, this can be overridden by using the commandline option `--config-file=<config-file>`. Config file is a JSON file containing 'rule' objects. Rules specify which parameter (from the JSON result of `i3-msg -t get_workspaces`) to use to decide the wallpaper.

Valid parameters are:

 - `num` (int)
 - `name` (str)
 - `visible` (bool)
 - `focused` (bool)
 - `output` (str)
 - `urgent` (bool)

### Example config.json:

```javascript
{
	"rules" : [
		["num",    1,        "/path/to/wallpaper_A.jpg"],
		["num",    2,        "/path/to/wallpaper_B.jpg"],
		["output", "HDMI-2", "/path/to/wallpaper_C.jpg"]
	],
	"default" : "/path/to/default/wallpaper.jpg"
}
```

In the above, workspaces indexed 1 and 2 are individually set wallpapers A and B respectively, all of the workspaces on output 'HDMI-2' are set wallpaper C, and the rest of the workspaces are set a default.

### Display indexing
Multiple displays are supported in nitrogen, and so they are here. By default, the displayes are indexed according to their order from `xrandr -q`, but if this is not correct for some reason it can be overridden by adding a dictionary object to the config:

```javascript
"display_indexing" : {
	"HDMI-1" : 1, // whatever your output is called, corresponding to a 0-based index
	"HDMI-2" : 0  // in xrandr, these displays would be swapped.
}
```

TODO
----
 - Add interop with other parts of i3-msg. `get_tree` especially could be cool; different wallpapers depending on the current active application or something
