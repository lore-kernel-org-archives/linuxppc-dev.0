Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18733.49643.63081.163437@cargo.ozlabs.ibm.com>
Date: Thu, 27 Nov 2008 08:38:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] of_gpio: Return GPIO flags from of_get_gpio()
In-Reply-To: <20081126162033.GA13397@oksana.dev.rtsoft.ru>
References: <20081030111500.GB22008@oksana.dev.rtsoft.ru>
	<1225418589-8545-1-git-send-email-tpiepho@freescale.com>
	<20081126162033.GA13397@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov writes:

> Can we apply it? Paul, Benjamin?
> 
> The patchwork url for this patch is:
> http://patchwork.ozlabs.org/patch/6650/
> 
> 
> Thanks!
> 
> >  drivers/mtd/nand/fsl_upm.c              |    2 +-
> >  drivers/net/fs_enet/fs_enet-main.c      |    2 +-
> >  drivers/net/phy/mdio-ofgpio.c           |    4 ++--
> >  drivers/of/gpio.c                       |   13 ++++++++++---
> >  drivers/serial/cpm_uart/cpm_uart_core.c |    2 +-
> >  include/linux/of_gpio.h                 |   21 +++++++++++++++++----
> >  6 files changed, 32 insertions(+), 12 deletions(-)

That would need acks from Jeff Garzik and David Woodhouse.

Alternatively you could add a new function (called, for instance,
of_get_gpio_flags) with the extra parameter to eliminate the need to
change any drivers at this stage, since they all seem to pass NULL for
the flags argument.

Paul.
