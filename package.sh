#! /bin/bash

log() {
    echo "$@"
}

clean() {
    log "Clean workdir"
    rm -rf "$work"
}

get() {
    log "Get source $name - $version"
    if [ -e "$download/$name/$version/$name.hpi" ]; then
        log "Already downloaded."
        return
    fi
    mkdir -p "$download/$name/$version"
    cd "$download/$name/$version"
    wget --output-document="${name}.hpi" http://updates.jenkins-ci.org/download/plugins/"${name}"/"${version}"/"${name}.hpi"
}

package() {
    log "Package $name - $version"
    mkdir -p "$work/$name/$version/var/lib/jenkins/plugins"
    cd "$work"
    cp "$download/$name/$version/$name.hpi" "$work/$name/$version/var/lib/jenkins/plugins"
    fpm -s dir -t deb --name "jpi-$name" --version "$version" --depends 'jenkins' -a all -C "$work/$name/$version" --post-install "$base/post-install.sh" .
}

base=$(dirname $(readlink -f "$0"))
work="$base/work"
download="$base/download"

set -e

clean
cat plugins.txt | while read line; do
    name=$(echo "$line" | awk '{ print $1 }')
    version=$(echo "$line" | awk '{ print $2 }')
    echo "Will do $name at $version"
    get
    package
done
