group "default" {
  targets = [
    "0_28_0",
    "0_29_0",
    "0_28_0_debian",
    "0_29_0_debian",
    "0_28_0_cudnn",
    "0_29_0_cudnn"
  ]
}

target "build-dockerfile" {
  dockerfile = "Dockerfile"
}

target "build-platforms" {
  platforms = ["linux/amd64", "linux/aarch64"]
}

target "build-platforms-cudnn" {
  platforms = ["linux/amd64"]
}

target "build-common" {
  pull = true
}

######################
# Define the variables
######################

variable "REGISTRY_CACHE" {
  default = "docker.io/nlss/lczero-cache"
}

######################
# Define the functions
######################

# Get the arguments for the build
function "get-args" {
  params = [version]
  result = {
    LCZERO_VERSION = version
  }
}

# Get the cache-from configuration
function "get-cache-from" {
  params = [version]
  result = [
    "type=registry,ref=${REGISTRY_CACHE}:${sha1("${version}-${BAKE_LOCAL_PLATFORM}")}"
  ]
}

# Get the cache-to configuration
function "get-cache-to" {
  params = [version]
  result = [
    "type=registry,mode=max,ref=${REGISTRY_CACHE}:${sha1("${version}-${BAKE_LOCAL_PLATFORM}")}"
  ]
}

# Get list of image tags and registries
# Takes a version and a list of extra versions to tag
# eg. get-tags("0.29.0", ["0.29", "latest"])
function "get-tags" {
  params = [version, extra_versions]
  result = concat(
    [
      "docker.io/nlss/lczero:${version}",
      "ghcr.io/n0rthernl1ghts/lc0:${version}"
    ],
    flatten([
      for extra_version in extra_versions : [
        "docker.io/nlss/lczero:${extra_version}",
        "ghcr.io/n0rthernl1ghts/lc0:${extra_version}"
      ]
    ])
  )
}

##########################
# Define the build targets
##########################

target "0_28_0" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.28.0")
  cache-to   = get-cache-to("0.28.0")
  tags       = get-tags("0.28.0", ["0.28"])
  args       = get-args("0.28")
}

target "0_29_0" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.29.0")
  cache-to   = get-cache-to("0.29.0")
  tags       = get-tags("0.29.0", ["0.29", "latest"])
  args       = get-args("0.29")
}

target "0_28_0_debian" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.28.0-debian")
  cache-to   = get-cache-to("0.28.0-debian")
  tags       = get-tags("0.28.0-debian", ["0.28-debian"])
  args       = get-args("0.28")
  dockerfile = "variations/debian/Dockerfile"
}

target "0_29_0_debian" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.29.0-debian")
  cache-to   = get-cache-to("0.29.0-debian")
  tags       = get-tags("0.29.0-debian", ["0.29-debian", "latest-debian"])
  args       = get-args("0.29")
  dockerfile = "variations/debian/Dockerfile"
}

target "0_28_0_cudnn" {
  inherits   = ["build-dockerfile", "build-platforms-cudnn", "build-common"]
  cache-from = get-cache-from("0.28.0-cudnn")
  cache-to   = get-cache-to("0.28.0-cudnn")
  tags       = get-tags("0.28.0-cudnn", ["0.28-cudnn"])
  args       = get-args("0.28")
  dockerfile = "variations/cudnn/Dockerfile"
}

target "0_29_0_cudnn" {
  inherits   = ["build-dockerfile", "build-platforms-cudnn", "build-common"]
  cache-from = get-cache-from("0.29.0-cudnn")
  cache-to   = get-cache-to("0.29.0-cudnn")
  tags       = get-tags("0.29.0-cudnn", ["0.29-cudnn", "latest-cudnn"])
  args       = get-args("0.29")
  dockerfile = "variations/cudnn/Dockerfile"
}
