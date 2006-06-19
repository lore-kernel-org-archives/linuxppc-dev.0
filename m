Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 82FA567B1B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 00:07:02 +1000 (EST)
Subject: Re: [PATCH 4/9 v3] Add starting of secondary 86xx CPUs.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1150599918.23600.150.camel@localhost.localdomain>
References: <E1Frjem-0004Ou-2S@jdl.com>
	<1150599918.23600.150.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1150725998.9022.8.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 19 Jun 2006 09:06:42 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-06-17 at 22:05, Benjamin Herrenschmidt wrote:

> > +BEGIN_FTR_SECTION
> > +	LOAD_BAT(4,r3,r4,r5)
> > +	LOAD_BAT(5,r3,r4,r5)
> > +	LOAD_BAT(6,r3,r4,r5)
> > +	LOAD_BAT(7,r3,r4,r5)
> > +END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
> >  	blr
> 
> Looks good.

Excellent.  Thanks.

jdl
