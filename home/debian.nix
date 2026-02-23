{ config, ... }:

{
  # Debian-specific environment variables
  home.sessionVariables = {
    DOCKER_APPS_DATA_PATH =
      "${config.home.homeDirectory}/apps/docker_apps";
  };
}
