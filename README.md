# FlipIt

A simple script to SSH into your server and swap out your website with a fresh git repo version with zero downtime.

Why? See my post: [Writing a Zero Downtime Deployment Script](https://timacdonald.me/writing-a-zero-downtime-deployment-script/).

## Installation

Git clone the repository onto your local machine and you can run the script from there.

```
git clone https://github.com/timacdonald/flipit.git
```

## Versioning

This package uses *Semantic Versioning*. You can find out more about what this is and why it matters by reading [the spec](http://semver.org) or for something more readable, check out [this post](https://laravel-news.com/building-apps-composer).

## Usage

```
# run the script (replace the arguments)
./flipit.sh -c SSH_CONNECTION_DETAILS -s SERVER_PUBLIC_FOLDER -r REPOSITORY_URL -g REPOSITORY_PUBLIC_FOLDER
```

## Contributing

Please feel free to suggest new ideas or send through pull requests to make this better. If you'd like to discuss the project, feel free to reach out on [Twitter](https://twitter.com/timacdonald87).

## License

This package is under the MIT License. See [LICENSE](https://github.com/timacdonald/flipit/blob/master/LICENSE.txt) file for details.