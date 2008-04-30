Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id B2C22DDEF4
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:55:37 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.25-git] spi_mpc83xx much improved driver
Date: Wed, 30 Apr 2008 15:55:33 -0700
References: <200804301537.07965.david-b@pacbell.net>
	<20080430154631.b86797de.akpm@linux-foundation.org>
In-Reply-To: <20080430154631.b86797de.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804301555.34110.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, 12o3l@tiscali.nl,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 April 2008, Andrew Morton wrote:
> > +     spin_lock_irq(&mpc83xx_spi->lock);
> 
> irq-safe.
> 
> > ...
> >
> > +     spin_lock(&mpc83xx_spi->lock);
> 
> not irq-safe.
> 
> Deliberate?

That latter one is inside an #if 0/#endif block, so it won't matter.
The #if 0 block bothered me.  Maybe Joakim can remove it.

(By the way, I'd feel safer about this patch if there were an
ack or two from more PPC folk...)
