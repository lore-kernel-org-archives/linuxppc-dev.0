Message-Id: <200007132354.AAA20368@hyperion.valhalla.net>
Date: Fri, 14 Jul 2000 00:53:45 +0100
Subject: [ANN] DMA sound patches V2[2.217pre10-ben2 & 2.4.0-test4]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Linuxppc-dev@lists.linuxppc.org,
        Linux-audio-dev@ginette.musique.umontreal.ca
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I have posted a version 2 of the LinuxPPC dmasound back-port from
V2.4.0-test4 to 2.2.17pre10-ben2.

Patches against this and 2.4.0-test4 (to add a bit more info about record
buffers on the AWACS) can be found on:

http://www.drfruitcake.com/linux/linuxppc.html

along with explanations etc.

Basically, there is now a single code-base with KERNEL_VERSION()
conditionals...

There is also a temporary (I expect) patch there that will get sound working
on G3 Minitower & desktops under 2.4.0-test4.  It is not especially
elegant... but it will get you going again.

Thanks to those who have tested so far - particularly Gwyn Judd.
Also thanks to Ben H & Geert for putting up with my dumb questions...

have fun,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
