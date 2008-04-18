Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A602EDE59D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 18:17:49 +1000 (EST)
Date: Fri, 18 Apr 2008 10:19:45 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200: add interrupt type function
Message-ID: <20080418081945.GO14658@pengutronix.de>
References: <20080415152954.GX13814@pengutronix.de>
	<20080417060031.GH13814@pengutronix.de>
	<fa686aa40804162341h5e68e460t975f69118ff8beca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804162341h5e68e460t975f69118ff8beca@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 11:41:08PM -0700, Grant Likely wrote:
> On Wed, Apr 16, 2008 at 11:00 PM, Robert Schwebel
> <r.schwebel@pengutronix.de> wrote:
> > On Tue, Apr 15, 2008 at 05:29:54PM +0200, Robert Schwebel wrote:
> >  > From: Sascha Hauer <s.hauer@pengutronix.de>
> >  >
> >  > Add a set_type function for external (GPIO) interrupts.
> >  >
> >  > Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
> >  > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> >  As we didn't get negative feedback yet, could this go into the 2.6.26
> >  merge window?
> 
> I didn't see this the first time (didn't get cc'd).
> 
> It looks mostly okay, but in doesn't have any mutual exclusion which
> it probably should have.  What are the users of this?

No, it is used in kernel/irq/chip.c and kernel/irq/manage.c. Both
callers already hold the mpc52xx_extirq_irqchip.lock spinlock.

Sascha


-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
