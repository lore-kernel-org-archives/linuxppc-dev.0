Date: Thu, 19 Dec 2002 08:49:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100 boot from flash
Message-ID: <20021219154911.GB852@opus.bloom.county>
References: <NDBBIFIMCKPOADMAJOKMKEOJEOAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMKEOJEOAA.s.coluccini@caen.it>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 19, 2002 at 10:03:03AM +0100, Stefano Coluccini wrote:

>   I have a MVME5100 and i can use Linux on it booting from the network, now
> I'm trrying to boot from flash but without success. I have thought to simply
> put the image that is good for the network boot in the flash bank with
> pflash, but it doesn't work. Anyone knows what i have to do or where i can
> found documentation about this topic ?

What .config are you using to generate a working kernel for this
machine?  IIRC, CONFIG_ALL_PPC won't generate a flash-bootable image by
default (look at arch/ppc/boot/simple/Makefile if you need to use this,
and not CONFIG_MVME5100), but CONFIG_MVME5100 will generate a
'zImage.bugboot' which can be put into flash and booted.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
