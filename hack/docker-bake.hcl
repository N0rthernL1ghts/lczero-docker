group "default" {
  targets = [
    "0_30_0",
    "0_31_0",
    "0_30_0_cudnn",
    "0_31_0_cudnn"
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
  params = [version, patch_version]
  result = {
    LCZERO_VERSION = version
    PATCH_VERSION  = patch_version
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

target "0_30_0" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.30.0")
  cache-to   = get-cache-to("0.30.0")
  tags       = get-tags("0.30.0", ["0.30"])
  args       = get-args("0.30", "0.29")
}

target "0_31_0" {
  inherits   = ["build-dockerfile", "build-platforms", "build-common"]
  cache-from = get-cache-from("0.31.0")
  cache-to   = get-cache-to("0.31.0")
  tags       = get-tags("0.31.0", ["0.31", "latest"])
  args       = get-args("0.31", "0.31")
}

target "0_30_0_cudnn" {
  inherits   = ["build-dockerfile", "build-platforms-cudnn", "build-common"]
  cache-from = get-cache-from("0.30.0-cudnn")
  cache-to   = get-cache-to("0.30.0-cudnn")
  tags       = get-tags("0.30.0-cudnn", ["0.30-cudnn"])
  args       = get-args("0.30", "0.29")
  dockerfile = "variations/cudnn/Dockerfile"
}

target "0_31_0_cudnn" {
  inherits   = ["build-dockerfile", "build-platforms-cudnn", "build-common"]
  cache-from = get-cache-from("0.31.0-cudnn")
  cache-to   = get-cache-to("0.31.0-cudnn")
  tags       = get-tags("0.31.0-cudnn", ["0.31-cudnn", "latest-cudnn"])
  args       = get-args("0.31", "0.31")
  dockerfile = "variations/cudnn/Dockerfile"
}
