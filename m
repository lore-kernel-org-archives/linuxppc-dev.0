Date: Tue, 11 Jun 2002 19:40:44 -0700
From: Matt Porter <porter@cox.net>
To: Shie Erlich <shie_e@elbit.co.il>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: no virtual terminals problem
Message-ID: <20020611194044.A28767@home.com>
References: <200206111735.21959.shie_e@elbit.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200206111735.21959.shie_e@elbit.co.il>; from shie_e@elbit.co.il on Tue, Jun 11, 2002 at 05:35:21PM +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 11, 2002 at 05:35:21PM +0000, Shie Erlich wrote:
>
> hi people,
> we're using hardhat with kernel 2.4.2. our system has a serial
> port, through which we're using the serial console.
> also, we have a PMC adapter on board, and we're trying to
> use it with a VGA card. we took a PCI VGA card (ATI RAGEpro),
> and attached it to the board, through a PCI2PMC adapter.
> /proc/pci identifies the card, and also the framebuffer device
> seems to recognize it, but all we get on screen is some green trash.

Let's step back and recognize who writes most of the commodity
VGA card FB drivers in the kernel.  x86 developers.  That means
that most of these drivers are incomplete for platforms that
don't have an x86 BIOS to perform the chipset's core initialization.

99% of time this is due to having a driver that doesn't fully
initialize the chipset.

FWIW, a full xpert98 driver was submitted to the fb team but seems
to have disappeared in all my searches.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
