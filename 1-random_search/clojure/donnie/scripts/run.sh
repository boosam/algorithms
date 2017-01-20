# SCRIPTS_DIR
OS=$(uname -a)
if [[ $OS =~ "Darwin"  ]];then
  # mac
  SCRIPTS_DIR=$([[ $0 = /* ]] && echo "$(dirname $0)" || echo "$(dirname $PWD/${0#./})")
else
  # linux
  SCRIPTS_DIR=$(dirname $(readlink -f $0))
fi

pushd "${SCRIPTS_DIR}/../"
docker run -it --rm --name my-running-app my-clojure-app
popd
