Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Add support for binary includes. 
In-reply-to: <20080530013418.GC26816@yookeroo.seuss> 
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<483EB7ED.2010909@freescale.com>
	<20080530013418.GC26816@yookeroo.seuss>
Date: Mon, 02 Jun 2008 15:22:40 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K3GYC-0008F8-1v@jdl.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, May 29, 2008 at 09:04:29AM -0500, Jon Loeliger wrote:
> >
> > I believe I am fully caught up at this point.
> 
> Not quite, this one slipped through the cracks:

Rats.

> dtc: Fix some printf() format warnings when compiling 64-bit
> 
> Currently, dtc generates a few gcc build warnings if built for a
> 64-bit target, due to the altered type of uint64_t and size_t.  This
> patch fixes the warnings (without generating new warnings for 32-bit).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Please use git for your patches.  Really.

Thanks,
jdl
