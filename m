Date: Tue, 10 Feb 2004 21:41:49 +0100
From: Colin Leroy <colin@colino.net>
To: debian-powerpc@lists.debian.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: mouseemu 0.7
Message-Id: <20040210214149.673a7819@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Just a note to say that I uploaded mouseemu 0.7 to
http://www.geekounet.org/powerbook/files/mouseemu.tar.gz

This new version grabs the mouse, which allows cleaner wheel emulation,
and fixes the bug that let left-click through when mod+lclick was used
for middle or right-click.
This version also implements a trackpad block while typing (mouse events
are eaten for N milliseconds (default 300) after a keypress).
Also, options are better parsed.

HTH,
--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
