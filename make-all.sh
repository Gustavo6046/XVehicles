#!/bin/sh

for rdir in XVehicles xZones XTreadVeh XWheelVeh FixGun; do
(
    set -e

    cd "$rdir"
    make "$@"
)
done
