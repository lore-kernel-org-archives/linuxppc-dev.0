Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Feb 2008 10:50:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212235058.GF21230@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de>
	<20080212003633.GF18348@localhost.localdomain>
	<20080212185106.GA4042@loki.buserror.net>
	<20080212231702.GB21230@localhost.localdomain>
	<47B22E98.8040900@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B22E98.8040900@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 05:41:12PM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> > I'm not sure I'm entirely happy about storing the fragments under a
> > special node - but certainly u-boot could do that if it wants.  What
> > would certainly be ok is to store various fragments as separate blobs
> > and fold them together as necessary.  Which reminds me, I meant to
> > implement a "graft" function in libfdt.
> 
> Most likely, U-Boot would strip out the special node after
> processing it.  The idea is for the boot loader to customize the
> device tree based before sending it to the kernel.

Of course.  U-boot can use whatever representation it likes
internally, as long as it's all fixed up by the time it reaches the
kernel.  I just think using sepa`rate "device tree fragment" blobs
might be a better way of doing it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
