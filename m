To: jfd@broadcom.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cheap FBDev for LinuxPPC
MIME-Version: 1.0
Message-ID: <OF0D44BB73.7E91414D-ONC1256D55.00228B80-C1256D55.002528B3@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Mon, 30 Jun 2003 08:28:22 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>I am working on a project with MPC8245 and have the need for a VGA
>>device which I can use to map the frame-buffer ram directly.
>>
>>A colleague of mine is recommending the SiliconMotion chipset.. could
>>anyone comment on this?

Excellent choice. I'm currently designing a board with a 405GPr and a
Silicon Motion SMI712 (also called LynxEM+).

>>If so, what cards could I purchase at Frye's or some store..

I don't know. I directly designed my board without buying an evaluation
board. I think that Eltec has a board with a Silicon Motion chip.

>>Finally, does anyone have any code for this baby?

Current version of U-Boot includes support for this chip.
I've found a framebuffer driver for Linux in the devel tree of Penguin
PPC.

At the time beeing, I have a problem with this chip which works in little
endian format and I have been unable to put it in big endian. So in 16bpp,
colors aren't displayed correcly.

>>Many thanks in advance.

You welcome

Laurent

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
