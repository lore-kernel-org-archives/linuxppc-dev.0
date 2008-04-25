Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5059DE104
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:40:37 +1000 (EST)
Date: Fri, 25 Apr 2008 15:42:59 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] add gpiolib support for mpc5200
Message-ID: <20080425134259.GO6692@pengutronix.de>
References: <20080424153659.GJ6692@pengutronix.de>
	<20080425130737.GA3430@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080425130737.GA3430@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 05:07:37PM +0400, Anton Vorontsov wrote:
> On Thu, Apr 24, 2008 at 05:36:59PM +0200, Sascha Hauer wrote:
> 
> > +#include <linux/of.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/io.h>
> > +#include <asm/of_platform.h>
> > +#include <asm/prom.h>
> > +#include <asm/gpio.h>
> 
> In the latest kernels the preferred way is to include <linux/gpio.h>,
> the patch introducing it was merged just recently, so few people know
> about it yet.

Yes, checkpatch told me, but doing so resulted in a compilation error.
This  only showed that a "select GENERIC_GPIO" was missing in my
patch. Will update.

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
