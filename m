Date: Wed, 15 Jan 2003 15:48:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Booting Linux from an already running linux
Message-ID: <20030115224857.GB21424@opus.bloom.county>
References: <8CD0F4AF-23B1-11D7-98E2-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8CD0F4AF-23B1-11D7-98E2-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 09, 2003 at 10:05:50AM +0100, Anders Blomdell wrote:
>
> Now that I have a Linux running with networking on a PrPMC800 running as
> NON-MONARCH, I wonder if anybody knows about a program that can start a
> fresh linux kernel from the filesystem. The reason I need this, is that the
> PrPMC800 PPC-Bug does not support network booting for NON-MONARCH operation
> (neither have I found any alternative that does), and downloading megabytes
> over the serial line is not very tempting.

The other option here, is to put a kernel into FLASH.  Google around
for bugboot, but IIRC, it's just a matter of 'make zImage', and then
normal mojo for writing a binary into the FLASH to boot, ensuring you
use zImage.bugboot, not zImage.prpmc800, or whatever.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
