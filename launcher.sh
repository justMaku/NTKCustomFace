#!/bin/sh

SIMULATOR_NAME="Apple Watch Series 4 - 44mm"

# Launch Apple Watch Simulator
echo "Starting Apple Watch Simulator"
xcrun simctl boot "$SIMULATOR_NAME" >/dev/null 2>&1
echo "Apple Watch Simulator succesfully started"

# Make sure we attach to the fresh Carousel process.
echo "Restarting Carousel Process"
while true; do
  killall Carousel 2>/dev/null;
  if [ $? -eq 0 ]; then
    continue
  else
    echo "Carousel has been killed."
    break
  fi
done

# And now make sure that Carousel has finished waking up.
while true; do
  PID=`pgrep -x "Carousel"`
  if [ -z $PID ]; then
    continue
  else
    echo "Carousel is running again."
    break
  fi
done

# Let's wait a while for the Carousel process to fully launch
sleep 5

# Attach & Inject
echo "Attaching and injecting our payload."
lldb -o 'command script import "lldb.py"' >/dev/null 2>&1
echo "Successfully injected custom watch face."
open -a Simulator
