
# Pomo  

  Command-line application for the [Pomodoro](http://www.pomodorotechnique.com/) time management technique.
  
## Description

With Pomo you can add, remove, list, view, and start timing tasks all via the 
command-line with a simple, slick interface. You are reminded of the remaining 
time on a task via Growl. These notifications appear half-way, at the 5 minute point, 
and when the task duration has expired. 
  
## Examples

View global or command specific help:
    $ pomo help
    $ pomo help add
    $ pomo help remove

Get started by adding a task:
    $ pomo add "Fix IE stying issues"
    
And another:
    $ pomo add "Destroy IE" --description "because IE is terrible"
    
List your tasks:
    $ pomo list
        0. Fix IE stying issues                : 25 minutes
        1. Destroy IE                          : 25 minutes

Start the first task:
    $ pomo start
    Started Fix IE stying issues, you have 25 minutes :)
    (=........................) 24 minutes remaining
    
Once you have completed the task, list again:
    $ pomo list
      √ 0. Fix IE stying issues                : 25 minutes
        1. Destroy IE                          : 25 minutes
        
At any time mid-task you may terminate pomo via CTRL + C, at which time
you may manually complete the task:
    $ pomo complete first
    $ pomo complete last
    $ pomo complete 1
    $ pomo complete 5
        
The next time you run `pomo start` the first incomplete task will start:
    $ pomo start
    
Or choose a specific task:
    $ pomo start first
    $ pomo start last
    $ pomo start 5
    
You may also remove tasks
    $ pomo remove first
    $ pomo remove last
    $ pomo remove 2
    $ pomo remove 1
    $ pomo remove 6
    $ pomo rm first
    $ pomo rm last
    
View task details:
    $ pomo view first
    $ pomo view last
    $ pomo view 5
    $ pomo view 1

Remove all tasks:
    $ pomo remove all
    $ pomo rm all

## License

(The MIT License)

Copyright (c) 2009 TJ Holowaychuk <tj@vision-media.ca>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, an d/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
