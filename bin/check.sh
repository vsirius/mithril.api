#!/bin/bash
RUNNING_CONTAINERS=`docker ps | wc -l`;
    if [ "${RUNNING_CONTAINERS//[[:space:]]/}" == "1" ]; then
      echo "[E] Container is not started\!";
      docker logs mithril_api --details --since 5h;
      exit 1;
    fi;
