Message-ID: <38C61ED8.E77126FB@inu.se>
Date: Wed, 08 Mar 2000 10:35:20 +0100
From: Bjvrn Lundberg <bjorn.lundberg@inu.se>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: USB driver for MPC850/823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The driver is developed under Malek's 2.2.5 for embedded PPC.
Since the documentation has been a bit poor for the USB host mode, much
had to be done with trial and error. Some of which is left in the
source.
Most changes are in new source files but some changes has been done in
commproc.c and .h to support RISC timers and more DPRAM (microcode
alert).
For some reason I couldn't use USB buffers in SDRAM, only DPRAM!?
As stated earlier on the list it's developed on an 850, but I haven't
found anything that says it won't work on an 823.

The USB-driver is a replacement for the UHCI or OHCI in the standard usb
stack.
It still needs to be URBified, so it's not up to date with the latest
developments
in the standard stack. It has been tested with the ACM driver (which is
included in the tar) and is running chat, ppp and mgetty. Also included
are the versions of usb.c usb-debug.c and usb.h used.

I did a tar (all changes are in arch/ppc/8xx_io) since I don't know how
useful a diff against 2.2.5 is when most are working on later versions.

Enjoy
  Bjorn

PS.
If You use chat, You'll find a bug in terminate(). Don't call fatal(),
it'll call terminate()....

PPS.
The mail was to big to be accepted to this list but you can find it
and the tar at

http://lists.suse.com/archives/linux-usb/2000-Mar/0234.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
