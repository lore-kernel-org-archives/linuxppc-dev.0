Return-Path: <absoluthunter@comcast.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 75C7E68682
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 12:51:53 +1100 (EST)
From: "Absolut Hunter" <absoluthunter@comcast.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 2 Nov 2005 17:40:16 -0800
Message-ID: <000901c5e017$91aef880$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: SM501 Frame Buffer driver on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I am attempting to bring up a SM501 frame buffer driver on our PPC MPC8280
board. Using the Denx Kernel 2.4.25 I see that most of this is already
included in the kernel.

However a few questions:

The TQM5200 Board uses this driver, but I am gathering this is a PCI based
video setup?; Our board uses a local bus memory interface. I.e. we have
setup the SM501 to be in the SH-3/4 Slave mode. 

We have dedicated 32Megs of Video memory to be local only to the SM501, and
mapped it to 0xF8000000 on /CS6, placing the registers at 0xFBE00000

Anyway, I have the UPMA machine setup to communicate with the SM501 and have
verified basic communication with registers, etc.. When using Linux the
kernel Oops's when register_framebuffer is called. I have setup the
voyager.h file to use the correct addresses.

Has anyone used the SM501 driver with this type of NON-Unified memory
architecture? I am guessing this can be confusing to the driver since the
frame buffer registers inside the SM501 need to be using offset ZERO instead
of the 0xF8000000 like the MPC8280 sees.

Thanks,

-Russell McGuire
