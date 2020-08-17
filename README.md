# COVID-19 Telegram Bot

> In project is a telegram covid-19 bot that can be initialized on the command line where it sends information about the current status of the disease.

> This is a capstone project for the ruby curriculum at microverse coding school.

## Built With

- Ruby 2.6.5
- Rubocop
- Ubuntu
- VS Code

## Prerequisities

To get this project up and running locally, you must already have ruby installed on your computer.

## Getting Started

- Download the [telegram](https://telegram.org/) for you mobile or computer
- Create a new account if you don't have one already
- In the search tab search for `@getcovidstatus_bot` or [click the this link](http://t.me/getcovidstatus_bot) to get the bot
- start the bot or using /start
- You are now ready to use the bot to get the latest COVID-19 updates

### Usage

You can interact with the bot in two ways.
**Enter the following to interact with the bot:**

- `/start` to get general information what to input to make insteraction with the bot.
- `/global` to get global cases
- `/country countryname` to get latest statistics of the country
  example: sending /country ethiopia will get you latest numbers of cases in ethiopia
- `/history countryname numberofdays` to get history of covid-19 of a country for a given number of days.
- `/continent continentName` to get covid-19 status for a continent.
- `/help` - get help with the bot.
- example: sending /history ethiopia 5 will get you history of ethiopia's status for the last five days.
- `/stop` to stop the bot

## Development

### Prerequisites

Since all the code is written using ruby `Ruby Runtime >= 1.9` ruby is required to interpret the code. if you don't have ruby runtime installed on your computer follow the instruction for your specific operating system on the [official installation guide](https://www.ruby-lang.org/en/documentation/installation/)

### Get source file

once you have setup all the prerequisites clone the repository on your development enviroment

`https://github.com/keddo/covid-19-telegram-bot.git`

Install all the gem dependencies for the project

`bundle install`

Install development enviroment setup packages

`npm install`

run the application

`ruby bin/main.rb`

## Authors

👤 **Kedir Abdurahman**

- Github: [@keddo](https://github.com/keddo)
- Twitter: [@kedirman](https://twitter.com/kedirman)
- LinkedIn: [@kedirabdurahman](https://www.linkedin.com/in/kedirabdurahman/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- This Project was part of an assignment available on The Odin Project.
- Our thanks to Microverse and all our peers and colleagues there.

## 📝 License

This project is [MIT](lic.url) licensed.
