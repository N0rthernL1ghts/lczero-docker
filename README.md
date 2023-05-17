<!-- Improved compatibility of back to top link: See: https://github.com/N0rthernL1ghts/lczero-docker/pull/73 -->
<a name="readme-top"></a>


<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
<h3 align="center">LCZero Docker Images</h3>

  <p align="center">
    S6 Supervised UCI engine/server for Leela Chess Zero
    <br />
    <a href="https://github.com/N0rthernL1ghts/lczero-docker"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/N0rthernL1ghts/lczero-docker/issues">Report Bug</a>
    ·
    <a href="https://github.com/N0rthernL1ghts/lczero-docker/issues">Request Feature</a>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project
There is no real docker support for LCZero project. The only [officially recommended](https://github.com/vochicong/lc0-docker) docker image is obsolete (Last update: 2019) <br/>
This project aims to provide a up-to-date docker image for LCZero that allows for automation and plug-and-play usage.<br/>
Unfortunately, only CPU (blas) backend is supported at the moment. <br/>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

You can use this image in two ways.

With docker run command: <br/>
```sh
docker run -d --name lczero -v "${PWD}/weights:/lczero/networks" -p 3333:3333 ghcr.io/n0rthernl1ghts/lc0:latest
```

Or with supplied [docker-compose.yml](docker-compose.yml): <br/>
```sh
cd lczero-docker
docker compose up -d
docker compose logs --follow
```



<!-- USAGE EXAMPLES -->
## Usage

### Container env variables
```dotenv
# Full SHA of the network. It will be downloaded and unpacked automaticaly, on container startup.
# This is done only once, only if network file does not exist.
LCZERO_NETWORK_SHA

# If this is defined, and file exists in internal /lczero/networks directory, it will be used instead of downloading network weights. 
# LCZERO_NETWORK_SHA will be ignored.
# This is useful if you want to use your own network weights.
# Example: LCZERO_NETWORK_FILENAME=network-12345678.pb.gz
# You can mount your own weights file to internal /lczero/networks directory.
LCZERO_NETWORK_FILENAME
```

### LCZero configuration env variables
Please refer to official LCZero for more information about these options.
- https://lczero.org/play/configuration/flags/#parameters-list
- https://lczero.org/dev/wiki/lc0-options/

```dotenv
# Lc0 0.28 and 0.29
LCZERO_VERBOSE_MOVE_STATS=true|false
LCZERO_BACKEND
LCZERO_BACKEND_OPTS
LCZERO_THREADS
LCZERO_NNCACHE
LCZERO_MINIBATCH_SIZE
LCZERO_MAX_PREFETCH
LCZERO_CPUCT
LCZERO_CPUCT_BASE
LCZERO_CPUCT_FACTOR
LCZERO_TEMPERATURE
LCZERO_TEMPDECAY_MOVES
LCZERO_TEMP_CUTOFF_MOVE
LCZERO_TEMP_ENDGAME
LCZERO_TEMP_VALUE_CUTOFF
LCZERO_TEMP_VISIT_OFFSET
LCZERO_SMART_PRUNING_FACTOR
LCZERO_FPU_STRATEGY
LCZERO_FPU_VALUE
LCZERO_CACHE_HISTORY_LENGTH
LCZERO_POLICY_SOFTMAX_TEMP
LCZERO_MAX_COLLISION_EVENTS
LCZERO_MAX_COLLISION_VISITS
LCZERO_OUT_OF_ORDER_EVAL
LCZERO_SYZYGY_FAST_PLAY
LCZERO_MULTIPV
LCZERO_SCORE_TYPE
LCZERO_HISTORY_FILL
LCZERO_KLDGAIN_AVERAGE_INTERVAL
LCZERO_MINIMUM_KLDGAIN_PER_NODE
LCZERO_MOVE_OVERHEAD
LCZERO_RAM_LIMIT_MB
LCZERO_USE_SYZYGY_TABLES
LCZERO_MAX_CONCURRENT_SEARCHERS

# Lc0 0.28 only
LCZERO_MULTI_GATHER

```
### Advanced env variables
```dotenv
# Change internal container path to networks/weights directory
LCZERO_NETWORKS_PATH

# URL where from to download network weights. You can customize it to download from your own server.
# Default: https://training.lczero.org/get_network?sha=
# Network hash LCZERO_NETWORK_SHA is automatically appended to the end of the URL
LCZERO_NETWORK_GET_URI

# Internal path to custom lc0 config template file. It must be parseable by Gomplate (https://gomplate.ca/).
# This is useful if you want to customize lc0 config file and include options that are not implemented in this image.
LCZERO_CUSTOM_CONFIG_TEMPLATE
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LIMITATIONS -->
## Limitations

- Only blas backend is supported (currently)
- No GPU support (yet)
- No training support (yet)
- Only 64-bit CPU support (this is intentional as 32-bit CPUs would be too slow anyway)
- Bundled binaries are compiled without CPU optimizations (this is intentional - as it builds it for current CPU)

<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Leela Chess Zero project](https://lczero.org/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/N0rthernL1ghts/lczero-docker.svg?style=for-the-badge
[contributors-url]: https://github.com/N0rthernL1ghts/lczero-docker/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/N0rthernL1ghts/lczero-docker.svg?style=for-the-badge
[forks-url]: https://github.com/N0rthernL1ghts/lczero-docker/network/members
[stars-shield]: https://img.shields.io/github/stars/N0rthernL1ghts/lczero-docker.svg?style=for-the-badge
[stars-url]: https://github.com/N0rthernL1ghts/lczero-docker/stargazers
[issues-shield]: https://img.shields.io/github/issues/N0rthernL1ghts/lczero-docker.svg?style=for-the-badge
[issues-url]: https://github.com/N0rthernL1ghts/lczero-docker/issues
[license-shield]: https://img.shields.io/github/license/N0rthernL1ghts/lczero-docker.svg?style=for-the-badge
[license-url]: https://github.com/N0rthernL1ghts/lczero-docker/blob/master/LICENSE.txt
[product-screenshot]: images/screenshot.png