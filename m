From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>,
        <yellowdog-general@lists.yellowdoglinux.com>
Subject: [ANN] New kernels, gmac, airport, usb...
Date: Sun, 2 Jul 2000 20:43:13 +0200
Message-Id: <20000702184313.25718@192.168.1.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've uploaded a new test kernel (2.2.17pre9-ben1) to the web page at

   <http://ppclinux.apple.com/~benh/>

This kernel contains all the various updates and fixes made since the
latest release, add some new stuffs like:

  - New USB backport from 2.4 (Suse latest backport)
  - New GMAC driver with support for multicast&promisc, better perfs, no
    longer corrupts memory
  - Changes to the ADB and USB Mac keyboard & mouse drivers (Franz Sirl)
    to handle the new Linux Input Drivers mecanism (see page for details)
  - Whatever I forgot ;)

On this page, you'll also find an Airport driver for the Apple Airport
card. It has been successfully tested with a Pismo powerbook, an iBook
and a G4 "Sawtooth". You need the latest kernel for it to work correctly,
and you should have this kernel's sources linked to /usr/src/linux in
order to compile it (it's downloadable in source form only). Useage is
similar to the wvlan_cs driver for the Lucent PCMCIA card, the interface
name is 'airport'.

WARNING: This kernel may contain bugs. I've made lots of efforts to avoid
that, but it's still possible that there are some. Please report me any
problem other than the "normal" mouse keyboard issues discussed on the
web page, and I'll get those fixed. Please test on your HW since I plan
to merge most (if not all) of those changes to the mainstream PPC kernel asap.

Have fun !
Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
