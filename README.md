# Kindle Annotator

[![Build Status](https://travis-ci.org/nateklaiber/kindle-annotator.png)](https://travis-ci.org/nateklaiber/kindle-annotator)

A utility script that allows you to scrape your Kindle **Highlights**,
**Notes**, **Books**, and **Authors** from your [Amazon Kindle Profile
Page](https://kindle.amazon.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kindle-annotator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kindle-annotator

## Usage

Amazon does not require a simple programatic way to retrieve any of this
information. In order to use this utility you will want to add your
Amazon _username_ and _password_ to the `.env` file.

> This information is only used by you and never stored, shared, or
> exposed.

```
USERNAME='user@example.com'
PASSWORD='password'
```

## Contributing

1. Fork it ( https://github.com/nateklaiber/kindle-annotator/fork )
2. Create your feature branch (`git checkout -b
   my-new-feature`USERNAME='user@example.com'
PASSWORD='password')
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
