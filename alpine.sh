#!/usr/bin/env bash

################################
function press_a_key_to_continue {
   read -rp ">> Press enter to continue or CTRL-C to abort."
}


function main {
    echo ""
    echo ">> get-eggs: piero.proietti@gmail.com-66b8815d.rsa.pub"
    echo ""
    cp -f piero.proietti@gmail.com-66b8815d.rsa.pub /etc/apk/keys/
    mkdir -p /tmp/"$DOAS_USER"/packages/alpine/x86_64/
    cd /tmp/"$DOAS_USER"/packages/alpine/x86_64/
    wget -O penguins-eggs-10.0.27-r1.apk https://sourceforge.net/projects/penguins-eggs/files/alpine/x86_64/penguins-eggs-10.0.27-r1.apk/download
    wget -O penguins-eggs-bash-completion-10.0.27-r1.apk https://sourceforge.net/projects/penguins-eggs/files/alpine/x86_64/penguins-eggs-bash-completion-10.0.27-r1.apk/download
    wget -O penguins-eggs-doc-10.0.27-r1.apk https://sourceforge.net/projects/penguins-eggs/files/alpine/x86_64/penguins-eggs-doc-10.0.27-r1.apk/download
    apk add penguins-eggs*
    apk add util-linux
    ln -s /usr/bin/doas /usr/bin/sudo
    echo "fuse" | tee /etc/modules-load.d/fuse.conf

    echo ">> get-eggs: finished! You can remove it"
}

if command -v doas >/dev/null 2>&1; then
    SUDO='sudo'
else
    SUDO='doas'
fi

main
