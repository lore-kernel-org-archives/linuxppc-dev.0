Date: Wed, 15 Jan 2003 09:25:12 +0530
From: Chirag Kantharia <kantharia@hathway.com>
To: "Gallant, John" <jgallant@vanteon.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Assistance with using /dev/fb0 and No X windows
Message-ID: <20030115092512.A809@toxic>
Reply-To: Chirag Kantharia <kantharia@hathway.com>
References: <4926614F7A31D411820F00D0B74FF7E0013D1A21@RDC03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4926614F7A31D411820F00D0B74FF7E0013D1A21@RDC03>; from jgallant@vanteon.com on Tue, Jan 14, 2003 at 05:17:22PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 14, 2003 at 05:17:22PM -0500, Gallant, John wrote:
| 2) Does anyone know of a driver for the LynxEM chip that is not from the
| XFree86 code base?

There is lynxfb.c in the linuxppc_2_4_devel tree
(http://www.penguinppc.org/dev/kernel.shtml). You can use that as the
starting point. It's a WIP.

| I am planning to "strategically advance to the rear" and go back to the
| PPCBoot code where I was able to get a few bands of color when the LOGO was
| supposed to be drawn on the screen.  If I can get that to work I am hoping
| that I can form a better understanding of the LynxEM chip to either create a
| limited driver or hack up the vga16fb.c file some more before I work on a
| limited driver.

A working fbset just proves that you are able to talk to the framebuffer
support in the kernel. It doesn't indicate that your framebuffer is
actually able to talk to your hardware.

--
Chirag Kantharia, symonds.net/~chyrag/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
