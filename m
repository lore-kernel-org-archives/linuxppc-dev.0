From: Benjamin Herrenschmidt <bh40@calva.net>
To: Adrian Cox <apc@agelectronics.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Date: Tue, 11 Jul 2000 12:17:14 +0200
Message-Id: <20000711101714.9717@mailhost.mipsys.com>
In-Reply-To: <396AEAC7.D8CACCB2@agelectronics.co.uk>
References: <396AEAC7.D8CACCB2@agelectronics.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Residual data is useful for things like finding the memory size, and for
>chips designed inside Apple. For almost everything else Linux already
>contains a device tree, built by PCI probing when the kernel boots^*. I
>don't see much need for a parallel, architecture specific, device tree.

In the case of Apple HW, the OF device tree is the only way to know about:

 - Interrupt routing & sense type (level/edge)
 - Machine model (for the machine device-specific stuffs we have)
 - Bits inside Apple ASICs (we could hard code everything, but that doesn't
   sound like a good idea, and the device tree also provide things like the
   MAC address of the eth chip)
 - Firmware boot path (to setup the OF boot and configure the bootloader)
 - PCI hierarchy with the Uni-N chip
 - Memory size (of course)
 - What else did I forget ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
