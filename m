Message-Id: <sf8d0c4a.082@mail.frequentis.com>
Date: Wed, 15 Oct 2003 08:58:43 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Patch fec.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I found following message:
http://lists.linuxppc.org/linuxppc-embedded/200305/msg00255.html

There Jean-Denis states:

2 - Or, the worst, in function mdio_read called through the ioctl,
which would hang the calling process.

We have an MPC860T custom board and uses DENX kernel 2.4.4.
In our project we use also a second ethernet pcmcia card, and we have to bound both ethernet cards as backup medium. We updsate the bounding.c file and compile it as module. It works, but if we enable the mii check on the bounding module the kernel crash. Our hardware has an hardware watchdog, so it resets within one second.

Does anyone have any idea how to patch the code to prevent this 'failure'?

best regards
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
