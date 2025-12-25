group "default" {
  targets = ["lc0", "lc0-cudnn"]
}

variable "REGISTRY_CACHE" {
  default = "docker.io/nlss/lczero-cache"
}

variable "LCZERO_VERSIONS" {
  default = {
    "0.30.0" = {
      lc_version = "0.30"
      patch_version = "0.29"
      extra_tags = ["0.30"]
    }
    "0.31.0" = {
      lc_version = "0.31"
      patch_version = "0.31"
      extra_tags = ["0.31", "latest"]
    }
  }
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

# Get the arguments for the build
function "get-args" {
  params = [lc_version, patch_version]
  result = {
    LCZERO_VERSION = lc_version
    PATCH_VERSION  = patch_version
  }
}

# Get the cache-from configuration
function "get-cache-from" {
  params = [version]
  result = [
    "type=registry,ref=${REGISTRY_CACHE}:${sha1("${version}-${BAKE_LOCAL_PLATFORM}")}",
    "type=registry,ref=${REGISTRY_CACHE}:${sha1("main-${BAKE_LOCAL_PLATFORM}")}"
  ]
}

# Get the cache-to configuration
function "get-cache-to" {
  params = [version]
  result = [
    "type=registry,mode=max,ref=${REGISTRY_CACHE}:${sha1("${version}-${BAKE_LOCAL_PLATFORM}")}",
    "type=registry,mode=max,ref=${REGISTRY_CACHE}:${sha1("main-${BAKE_LOCAL_PLATFORM}")}"
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

target "lc0" {
  inherits = ["build-dockerfile", "build-platforms", "build-common"]
  matrix = {
    version = keys(LCZERO_VERSIONS)
  }

  name = replace(version, ".", "_")
  args = get-args(LCZERO_VERSIONS[version].lc_version, LCZERO_VERSIONS[version].patch_version)
  tags = get-tags(version, LCZERO_VERSIONS[version].extra_tags)
  cache-from = get-cache-from(version)
  cache-to   = get-cache-to(version)
}

target "lc0-cudnn" {
  inherits = ["build-dockerfile", "build-platforms-cudnn", "build-common"]
  dockerfile = "variations/cudnn/Dockerfile"
  matrix = {
    version = keys(LCZERO_VERSIONS)
  }

  name = "${replace(version, ".", "_")}_cudnn"
  args = get-args(LCZERO_VERSIONS[version].lc_version, LCZERO_VERSIONS[version].patch_version)
  tags = get-tags("${version}-cudnn", [for t in LCZERO_VERSIONS[version].extra_tags : "${t}-cudnn"])
  cache-from = get-cache-from("${version}-cudnn")
  cache-to   = get-cache-to("${version}-cudnn")
}