2.0.1 / 2012-12-16
==================

  * Minor fix bug release for tmux status bar coloring.

2.0.0 / 2012-12-16
==================

  * Added detach mode, on by default. To get the 1.x progress bar run `pomo start -p`. Closes #1
  * Added notification support for Mac OS X User Notifications, Quicksilver and libnotify.
    Growl continues to be supported. Closes #23
  * Added optional tmux status bar support to display Pomo timer.
  * Fixed import of Github issues list. Closes #11
  * Added support for importing a single Github issue. Closes #2
  * Added `pomo ls` as an alias to `pomo list`

1.0.1 / 2010-03-10
==================

  * Force UTF-8 encoding for Ruby 1.9

1.0.0 / 2010-01-19
==================

  * Fixed `pomo start`; starts the first incomplete task by default. Closes #3
  * Progress bar outputs immediately with latest commander installed

0.5.0 / 2010-01-14
==================

  * Added cleaner checkmark. Closes #16

0.4.0 / 2009-11-23
==================

  * Added `pomo edit` [thanks noonat]
  * Added `pomo incomplete` [thanks noonat]

0.3.1 / 2009-11-23
==================

  * Fixed `pomo import` due to octopi gem changes

0.3.0 / 2009-11-10
==================

  * Added total minutes to list output

0.2.0 / 2009-10-28
==================

  * Added several metadata related methods to Pomo::GithubTask
  * Added `pomo init` for localized .pomo
  * Normalized verbose messages
   
0.1.0 / 2009-10-16
==================

  * Added `pomo import <user> <project>`
  * Added Pomo::GithubTask

0.0.5 / 2009-10-16
==================

  * Added `pomo break`
  * Added `pomo clear` alias of `pomo remove all`
  * Default `pomo` to `pomo list`

0.0.4 / 2009-10-15
==================

  * Added / implemented selection api via Pomo::List#find

0.0.3 / 2009-10-15
==================

  * Added --complete switch for `pomo list`
  * Added --incomplete switch for `pomo list`
  * Changed INT message; more user-friendly
  
0.0.2 / 2009-10-15
==================

  * Added `pomo remove all`
  * Added `pomo complete`
  
0.0.1 / 2009-10-15
==================

  * Initial release
