Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6383BDDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 09:31:53 +1100 (EST)
Date: Thu, 27 Nov 2008 01:31:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] of_gpio: Return GPIO flags from of_get_gpio()
Message-ID: <20081126223151.GA1178@oksana.dev.rtsoft.ru>
References: <20081030111500.GB22008@oksana.dev.rtsoft.ru>
	<1225418589-8545-1-git-send-email-tpiepho@freescale.com>
	<20081126162033.GA13397@oksana.dev.rtsoft.ru>
	<18733.49643.63081.163437@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <18733.49643.63081.163437@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2008 at 08:38:51AM +1100, Paul Mackerras wrote:
[...]
> > >  drivers/mtd/nand/fsl_upm.c              |    2 +-
> > >  drivers/net/fs_enet/fs_enet-main.c      |    2 +-
> > >  drivers/net/phy/mdio-ofgpio.c           |    4 ++--
> > >  drivers/of/gpio.c                       |   13 ++++++++++---
> > >  drivers/serial/cpm_uart/cpm_uart_core.c |    2 +-
> > >  include/linux/of_gpio.h                 |   21 +++++++++++++++++----
> > >  6 files changed, 32 insertions(+), 12 deletions(-)
> 
> That would need acks from Jeff Garzik and David Woodhouse.
> 
> Alternatively you could add a new function (called, for instance,
> of_get_gpio_flags) with the extra parameter to eliminate the need to
> change any drivers at this stage, since they all seem to pass NULL for
> the flags argument.

:-))

This was _exactly_ my initial approach, but Trent and Grant thought
that changing API would be easy. Hah-ha!

Here is my initial patch implementing of_get_gpio_flags():
http://lkml.org/lkml/2008/7/25/236

Trent, are you going to push your patch through all the
maintainers, or should we, after all, revert to my approach
instead?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
