# UKAcademicCalendar

<div style="display:flex;">
    <a href="https://badge.fury.io/rb/uk_academic_calendar"><img src="https://badge.fury.io/rb/uk_academic_calendar.svg" alt="Gem Version" height="18"></a>
</div>

Designed to assist in Ruby programs dealing with the UK Academic Calendar, i.e. the Sept - Sept academic year, and the 3 'terms' (Autumn, Spring, Summer).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uk_academic_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uk_academic_calendar

## Usage

```ruby
require 'uk_academic_calendar'

# Assuming today is 20th Jan 2024
Date.today.academic_year #=> 2023
Date.today.beginning_of_academic_year #=> 2023-09-01
Date.today.end_of_academic_year #=> 2024-08-31
# or...
Time.now.academic_year #=> 2023
Time.now.beginning_of_academic_year #=> 2023-09-01 00:00:00 +0100
Time.now.end_of_academic_year #=> 2024-08-31 23:59:59.999999999 +0100

term_now = Date.today.academic_term #=> Spring 2023/2024
term_now.start_date #=> 2024-01-01
term_now.end_date #=> 2024-03-31, i.e. Easter Sunday
term_now.start_date = '2025-01-01' #=> raises #UKAcademicCalendar::InvalidTermStart error
term_now.to_range #=> (2024-01-01..2024-03-31)
term_now.all_dates #=> #<SortedSet:{Mon, 01 Jan 2024...}
```

See rubydoc [docs](https://www.rubydoc.info/github/m-smiff/uk_academic_calendar/main) for full details on the API (with help from Yard).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contribution

We are using [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) and an [automated release action](https://github.com/google-github-actions/release-please-action). Please ensure you familiarise youself with these before contributing.

## TODO

- Further granularity around the 'teachable', and inversely, 'unteachable' days within a term (e.g. adding bank holidays/inset days etc)
- Considering the above, implementation of e.g., `#teachable_days` and `#non_teachable_days` returning sorted sets of applicable dates
- Setting of 'contexts' so terms understand what dates to apply for a given 'context' (e.g. a particular local authority)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<hr />

<div style="display:flex;justify-content:space-around;">
    <a href="https://www.buymeacoffee.com/m_smiff" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</div>
