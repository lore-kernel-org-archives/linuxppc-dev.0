Date: Thu, 31 Jul 2003 14:07:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Richard Danter <richard.danter@windriver.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question
Message-ID: <20030731140700.A7553@home.com>
References: <3F2949D3.8020106@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F2949D3.8020106@windriver.com>; from richard.danter@windriver.com on Thu, Jul 31, 2003 at 05:54:43PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[Oh my !#$!@.  I never thought I'd be replying to a Linux question
 from WRS. I need to check for reports of natural disasters and
 mass rioting. :)]

On Thu, Jul 31, 2003 at 05:54:43PM +0100, Richard Danter wrote:
> I am trying to port a 2.4.x kernel to a PPC750 board with a 107
> controller. The board has a serial port connected to one of the ROM
> select lines (at 0x7C000000) and I would like to use this as my console
> port.

No problem.

> So far I can boot the board and see (via the serial port) the kernel
> load addresses etc, and the kernel gets decompressed and starts to run.
> This is all fine as the MMU is off at this point. However, when the
> serial_console_setup() code starts trying to configure the serial port
> again, I get a kernel panic as I am accessing an invalid mem space (MMU
> now on!).
>
> How do I map this correctly???

In 2.4, you can use early_serial_setup() or io_block_map().  It is
highly recommended to use early_serial_setup().  There are many
examples of this (spruce, lopec, etc.)

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
