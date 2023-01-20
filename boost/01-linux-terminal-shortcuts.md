# Linux Terminal Shortcuts

Contains a list of various shortcuts and commands that can be used to perform
specific tasks on a Linux operating system through the terminal. There are 
many shortcuts available depending on the shell and terminal emulator being 
used.

## Common terminal shortcuts

* `Tab`: Auto-complete a command or file name.

* `Ctrl + C`: Terminate the running command.

* `Ctrl + L`: Clear the terminal screen.

* `Ctrl + A`: Move the cursor to the beginning of the line.

* `Ctrl + E`: Move the cursor to the end of the line.

* `Ctrl + U`: Clear the entire line before the cursor.

* `Ctrl + K`: Clear the entire line after the cursor.

* `Ctrl + W`: Clear the word before the cursor.

* `Ctrl + R`: Search through previously used commands.

* `Ctrl + Z`: Suspend the running command.
  * Use `bg` command to send suspended process to continue running in the 
  background and allow the terminal to continue accepting new commands. Only 
  works with last suspended process.
  * Use `fg` to bring the last suspended command to the foreground. Or use 
  `fg <jobid>` to choose a specific job.
  * Use `jobs` to find a specific job id.  
    Note:
    > Jobs are are assigned to the shell instance and when you close or exit
    the shell, the jobs are terminated as well. If you want to keep jobs running even after you log out, explore `nohup`, `disown`, `tmux`

* `Ctrl + D`: Exit the terminal.