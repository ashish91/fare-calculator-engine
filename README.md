# Fare Calculator engine

## How to run ?

- Run bin/run_setup.sh.
- Run bin/run_engine.sh.
- Inputs can be edited in bin/main.rb.

## Directory Structure

- Bin - Contains executables.
    * main - main program to execute.
    * run_engine - starting the program.
    * require_tree - require various classes in this project.
    * run_tests - runs test cases using rspec.
    * setup - sets up your local machine.
- Models - Data models for persisting data in memory and defines relationships between them.
    * daily_cap/weekly_cap - Defines one daily/weekly total cap and longest journey for the day/week. This is used to calculate if the cap should be applied when the total cap reaches the limit.
    * day - defines day.
    * timing_range - TimingRange defines a single start to end time interval.
    * day_time_ranges - defines collection of days and timing_ranges. This is used to hold the days and timings for lets say peak hours or any other type of hours defined in timings.yml.
    * timing_type - defines a single timing defined in timings.yml. Currently there is peak and off_peak. The default timing is off_peak.
    * fare - defines a single fare from fares.yml. It contains the journey it is applicable for and fares for each timing_type defined in timings.yml.
    * fare_cap - defines a single fare cap from fare_caps.yml. It contains the journey it is applicable for and daily/weekly capping limit.
    * journey - defines a journey from one zone to another zone.
- Services - Business Logic class responsible for doing one activity.
    * FareMatchingService - fares are defined in fares.yml. Currently there are two types of fares peak and off_peak. fare requires zones like 1 to 2 which means the fare will be applied on journey from 1 to 2.
    * TimingMatchingService - defines config for peak and off_peak hours. Each timings has days when it's applied which is defined as [0-7] and timings which are intervals defined for those days. So if the timing is Monday and Tuesday then add 0,1 to days and then add interval like 07:00-10:00. This is configured in config/timings.yml.
    * FareCappingService - fare capping service defines the daily and weekly cap. Caps are matched via journey. This can be configured in fare_cap.yml.
- Specs - Contains the test cases.
- Gemfile - Defines external libraries which are required. This project requires rspec for running tests and pry for debugging.
- Gemfile.lock - locked versions of external libraries.
- .ruby-version - Required ruby version.
- README.md - README file.

## What does setup do ?

bin/setup will install following things on your laptop:

- rvm - Ruby version manager.
- Ruby 2.7.0.
- bundler gem for Gemfile.

