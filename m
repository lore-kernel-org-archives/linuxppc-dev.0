Date: Tue, 25 Feb 2003 16:14:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tom Guilliams <tguilliams@sbs.com>
Cc: Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC NvRam Support???
Message-ID: <20030225231415.GA4977@ip68-0-152-218.tc.ph.cox.net>
References: <1046210297.7412.28.camel@corona>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1046210297.7412.28.camel@corona>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 25, 2003 at 01:58:18PM -0800, Tom Guilliams wrote:

> I'm looking for NVRAM support (/dev/nvram) for the M48T37V 32K x 8
> Timekeeper SRAM chip.  Not only that, but drivers/char/nvram.c in the
> 2.4 development tree doesn't seem to support PPC at all.  I must be
> missing something or going about this the wrong way.  There appears to
> be RTC support for that chipset but no NVRAM.  Can anyone shed some
> light on PPC NVRAM support?  Thanks in advance for any help.

Well, what are you trying to do exactly?  The drivers/char/nvram.c
driver should be able be made to work on a 'pc' style nvram with a
little work.  NVRAM support is currently funky because powermacs cannot
use the drivers/char/nvram.c driver, but did use CONFIG_NVRAM.  You
could try just removing the PPC check in drivers/char/Makefile and see
what happens.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
