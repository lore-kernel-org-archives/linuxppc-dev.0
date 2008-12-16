Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E3E0DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 04:17:52 +1100 (EST)
Date: Tue, 16 Dec 2008 09:16:46 -0800
From: Greg KH <gregkh@suse.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: adding of_platform_drivers (was: Re: [RESEND][PATCH] uio: Add
	of_platform_driver to uio_pdrv_genirq)
Message-ID: <20081216171646.GA12812@suse.de>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
	<20081211205033.GA7080@suse.de>
	<20081216122731.GC3275@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081216122731.GC3275@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, hjk@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 16, 2008 at 01:27:32PM +0100, Wolfram Sang wrote:
> > > +/* ---------------------------------------------------------------------
> > > + * OF bus binding
> > > + */
> > > +
> > > +#if defined(CONFIG_OF)
> > 
> > Same goes here, don't put #if in .c files please.
> 
> So, generally speaking, this means that I should not put a
> platform_driver and an of_platform_driver into one source file, but
> rather create an of_$DRIVER.c then?

Yes, this is the preferred way to do it.

thanks,

greg k-h
