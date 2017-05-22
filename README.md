# spinner.sh

  Display an awesome 'spinner' while running your long shell commands

Do *NOT* call _spinner function directly.
Use spinner_{start,stop} wrapper functions!

## Usage

  1. source this script in your's
  2. start the spinner:
      spinner_start [display-message-here]
  3. run your command
  4. stop the spinner:
      spinner_stop [your command's exit status]

### Options

  1. Use timer with ``SPINNER_TIMER=true``
  2. Configure spin speed with ``SPINNER_DELAY=0.5``

_See also: test.sh_
