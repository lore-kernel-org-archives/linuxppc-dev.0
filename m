Return-Path: <vitb@kernel.crashing.org>
Received: from vitb-lp (unknown [89.169.139.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C760DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 16:12:14 +1000 (EST)
Date: Thu, 1 May 2008 09:47:38 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: drivers/net/fec_8xx config problem
Message-ID: <20080501094738.13dca29a@vitb-lp>
In-Reply-To: <20080430192329.GA9150@ld0162-tx32.am.freescale.net>
References: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
	<20080430192030.GA9084@ld0162-tx32.am.freescale.net>
	<151BA0B1-A188-41C7-B2DB-E8D63D15C218@freescale.com>
	<20080430192329.GA9150@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: jengelh@linux01.gwdg.de,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 14:23:29 -0500
Scott Wood wrote:

> On Wed, Apr 30, 2008 at 02:24:19PM -0500, Becky Bruce wrote:
> > 
> > On Apr 30, 2008, at 2:20 PM, Scott Wood wrote:
> > >On Wed, Apr 30, 2008 at 02:19:21PM -0500, Becky Bruce wrote:
> > >>I just noticed that the fec_8xx driver is not currently reachable
> > >>via menuconfig because it depends on 8XX instead of 8xx.
> > >[snip]
> > >>Since nobody has noticed this problem, I'm wondering if this
> > >>driver is still in (infrequent) use, or if it's been superseded
> > >>and should be removed, or if I'm just completely missing
> > >>something with respect to the use of "8XX" instead of "8xx".
> > >
> > >It's been superseded by drivers/net/fs_enet.
> > 
> > Is there any reason we haven't removed it?
> 
> To keep arch/ppc/8xx_io company? :-)
> 
> > If not, I can push a patch to yank it.
> 
> I have no objection.

I am OK with this too. Should have been done long ago, but who likes janitorial stuff :)

-Vitaly
