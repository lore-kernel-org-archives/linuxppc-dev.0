Message-ID: <389703FC.A78E9811@netx4.com>
Date: Tue, 01 Feb 2000 11:04:12 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Raphael Bossek <raphael.bossek@gmx.de>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA-IDE for mpc8xx-linux-2.2.13
References: <11497.949395129@www14.gmx.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Raphael Bossek wrote:


> i really need this patch and if someone done it allready (it does not have
> to be perfect) so please let me know !!!

This kernel already has a hack in the m8xx_setup.c function to
use a PCMCIA ATA device.  All you need to do is enable basic IDE
and select the  IDE disk driver.  Don't get carried away and enable
too much stuff.

You have to initialize the PCMCIA (especially the power stuff)
according to your board.  There are two patches missing from
the asm-ppc/ide.h file for interrupt routing when using the
PCMCIA.  I will send those to you personally.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
