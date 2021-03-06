#!/bin/bash

NIMIQ_VERSION=`grep -m 1 version ../package.json`

cat > npm/package.json <<_EOF_
{
  "name": "@nimiq/core-web",
$NIMIQ_VERSION
  "homepage": "https://nimiq.com/",
  "description": "",
  "author": {
    "name": "The Nimiq Core Development Team",
    "url": "https://nimiq.com/"
  },
  "license": "Apache-2.0",
  "bugs": {
    "url": "https://github.com/nimiq/core-js/issues"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/nimiq/core-js.git"
  },
  "main": "web.esm.js",
  "types": "types.d.ts",
  "files": [
    "nimiq.js",
    "nimiq.js.map",
    "package.json",
    "VERSION",
    "web-babel.js",
    "web-babel.js.map",
    "web.js",
    "web.js.map",
    "web.esm.js",
    "web.esm.js.map",
    "web-offline.js",
    "web-offline.js.map",
    "worker.js",
    "worker-js.js",
    "worker.js.map",
    "worker-wasm.js",
    "worker-wasm.wasm",
    "types.d.ts",
    "namespace.d.ts"
  ]
}
_EOF_

cp ../dist/{namespace.d.ts,nimiq.js,nimiq.js.map,types.d.ts,VERSION,web-babel.js,web-babel.js.map,web.js,web.js.map,web.esm.js,web.esm.js.map,web-offline.js,web-offline.js.map,worker.js,worker-js.js,worker.js.map,worker-wasm.js,worker-wasm.wasm} npm/
cd npm

echo "
#####################################################################
# Running a test first: 'npm publish --access public --dry-run'     #
#####################################################################
"
npm publish --access public --dry-run

echo "
#####################################################################
# The real deal: 'npm publish --access public'                      #
#####################################################################
"

read -p "Does everything looks right in the previous output?
Should I run it for real this time? (yes/no) " yn
case $yn in
    [Yy]es|[Yy] ) npm publish --access public;;
    * ) echo "Mission aborted";;
esac
