# Calendar Cleaner

Cleans Google Calendar events based on a set of rules.

## Setup

1. Obtain credentials for the Google Calendar API. See "Step 1" of [Google's quickstart](https://developers.google.com/google-apps/calendar/quickstart/ruby#step_1_turn_on_the_api_name)
2. Save `client_secret.json` to this directory.
3. Install dependencies: `bundle install`

## Usage

```bash
ruby calendar-cleaner.rb
ruby calendar-cleaner.rb --help
ruby calendar-cleaner.rb --start "2017-01-01" --end "2017-01-07"
ruby calendar-cleaner.rb --start "2017-01-01" --end "2017-01-07" --calendar "foo@group.calendar.google.com"
```
