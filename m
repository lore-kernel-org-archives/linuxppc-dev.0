From: Markus Klotzbuecher <mk@creamnet.de>
Reply-To: mk@creamnet.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: [ANNOUNCE] Overlay Filesystem "mini_fo" released
Date: Thu, 1 Apr 2004 22:14:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404012214.01460.mk@creamnet.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am pleased to announce the release of the "mini_fo" (= mini fan-out)
overlay filesystem. This filesystem was specifically desgined to
overlay the root filesystem of embedded systems in order to easily be
able to apply software updates. It functions similar to the FreeBSD
union filesystem and serves to virtually make a read-only filesystem
writable.

The "mini_fo" filesystem was developed by extending a fistgen
generated stackable filesystem (see www.filesystems.org) to stack on
top of two lower layers.

This project was the final thesis for my degree in Computer Science.
The thesis paper and source code are available at www.denx.de. The
code is stable and already actively used in a telecommunications
project within Siemens. However, not all features are implemented
yet, but I plan to continue developement. Any help is welcome!

Regards

Markus Klotzbücher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
