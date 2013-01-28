# Pomo [![Build Status](https://travis-ci.org/visionmedia/pomo.png?branch=master)](https://travis-ci.org/visionmedia/pomo) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/visionmedia/pomo)

Command-line application for the [Pomodoro](http://www.pomodorotechnique.com/)
time management technique, with notification and tmux status bar support.

## Description

With Pomo you can add, remove, list, view, and start timing tasks all via the 
command-line with a simple, slick interface. You are reminded of the remaining 
time on a task via Notification Center, Growl, libnotify, or Quicksilver.
These notifications appear half-way, at the 5 minute point, and when the task
duration has expired. Also, the Pomo timer can be displayed in your tmux
status bar.

## Installation

    $ gem install pomo

## Configuration

Pomo uses `~/.pomorc` for configuration options.

To initialize a default configuration file:

    $ pomo initconfig

See [Configuration Options](#configuration-options) for more details on all the available options.

## Task Selection API

Taken from `pomo help`:

    pomo provides a unified task selection api which can be used
    with most of the commands. Commands with [task] or [task ...]
    in their synopsis accept only single or both single and multiple
    task selection, respectively.

    Single task selection:
    n          : selects a single task by index : Ex: pomo remove 1
    first      : selects the first task         : Ex: pomo remove first
    last       : selects the last task          : Ex: pomo remove last

    Multiple task selection:
    [n ]+      : selects several tasks by index : Ex: pomo remove 2 8 1
    [n..n]+    : selects a range of tasks       : Ex: pomo remove 5..9 11..14
    [n..-n]+   : selects a range of tasks       : Ex: pomo remove 2..-1
    [api ]+    : selects several tasks by api   : Ex: pomo remove first last
    complete   : selects complete tasks         : Ex: pomo remove complete
    incomplete : selects incomplete tasks       : Ex: pomo remove incomplete
    all        : selects all tasks              : Ex: pomo remove all

## Examples

  * View global or command specific help:

        $ pomo help
        $ pomo help add
        $ pomo help remove

  * Get started by adding a task:

        $ pomo add "Fix IE6 stying issues"
    
    And another:

        $ pomo add "Destroy IE6" --description "because IE6 is terrible"
    
  * List your tasks (or use `pomo` which defaults to `pomo list`):

        $ pomo list
            0. Fix IE6 stying issues                : 25 minutes
            1. Destroy IE6                          : 25 minutes

  * Start the first incomplete task:

        $ pomo start

    A notification window will display:

![Pomo OS X Notification](http://i.imgur.com/iEfdZ.png)

  * Alternatively, you can start the first incomplete task with a progress bar:

        $ pomo start --progress
        Started Fix IE6 stying issues, you have 25 minutes :)
        (=........................) 24 minutes remaining
    
  * Once you have completed the task, list again (alternatively `pomo ls`):

        $ pomo ls
          ✓ 0. Fix IE6 stying issues                : 25 minutes
            1. Destroy IE6                          : 25 minutes
        
  * Or take a break:

        $ pomo break
        $ pomo break 10
        $ pomo break --length 10
        
  * List only remaining tasks:

        $ pomo ls --incomplete
            1. Destroy IE6                          : 25 minutes
        
  * List only completed tasks:

        $ pomo ls --complete
          ✓ 0. Fix IE6 stying issues                : 25 minutes

  * At any time mid-task you may terminate pomo via CTRL + C, at which
    time you may manually complete the task:

        $ pomo complete first
        $ pomo complete last
        $ pomo complete 1
        $ pomo complete all
        $ pomo complete incomplete
        $ pomo complete 5..7

  * The next time you run `pomo start` the first incomplete task
    will start:

        $ pomo start
    
    Or choose a specific task:

        $ pomo start first
        $ pomo start last
        $ pomo start 5
    
  * You may also remove tasks:

        $ pomo remove first
        $ pomo remove last
        $ pomo remove 2
        $ pomo remove 1
        $ pomo remove 6
        $ pomo rm first
        $ pomo rm 2..5
        $ pomo rm 1..-1
    
  * View task details:

        $ pomo show first
        $ pomo show last
        $ pomo show 5
        $ pomo show 1 2 3

  * Remove all tasks:

        $ pomo remove all
        $ pomo rm all

  * Or if you prefer, create a directory specific task list. Pomo will
    auto-detect `./.pomo` in this directory, and utilize its contents.

        $ pomo init

## Configuration Options

The default configuration for pomo is as follows:

* Notification library is set to Notification Center on OSX 10.8; Growl on OSX
10.7 or less and Windows; and libnotify on Linux
* Progress bar is turned off
* tmux integration is turned off

Settings are easily customizable. Taken from `pomo help initconfig`:

    Examples:

    # Configure with notification center, no progress bar, and tmux integration
    pomo initconfig --notifier notification_center --no-progress --tmux

    Options:
      --notifier <lib>     Specify notificaiton library: `notification_center`, `libnotify`, `growl`, `quicksilver` 
      --[no-]progress      Run with progress bar 
      --[no-]tmux          Refresh tmux status bar on timer change 
      --[no-]force         force overwrite of existing config file 

### Tmux Status Bar Integration

Pomo's timer can be displayed in tmux's status bar with the following
configuration set:

    pomo initconfig --tmux

Then add the below to your `~/.tmux.conf`:

    set-option -g status-right '#(cat ~/.pomo_stat)'

The timer will display with the default color when not active,
green during a Pomodoro, red during the last 5 minutes of a Pomodoro,
and blue during a break e.g.

![tmux status bar](http://i.imgur.com/uIzM3.png)

## Contributing

We :heart: pull requests and feedback. Feel free to
[submit a ticket](https://github.com/visionmedia/pomo/issues) or see
[CONTRIBUTING](https://github.com/visionmedia/pomo/blob/master/CONTRIBUTING.md)
for details on pull requests.

## Copyright

Copyright (c) 2012 TJ Holowaychuk. See
[LICENSE](https://github.com/visionmedia/pomo/blob/master/LICENSE.md)
for details.
