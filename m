Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 208DEDE04B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:31:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9C3VAX1021721
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:31:10 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9C3Yi7Y286696
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:34:44 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9C3Ur5O005992
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:54 +1000
Date: Fri, 12 Oct 2007 13:15:54 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] [POWERPC] Kilauea DTS
Message-ID: <20071012031554.GF21056@localhost.localdomain>
References: <200710081110.16447.sr@denx.de> <200710111049.02253.sr@denx.de>
	<1192103498.5534.101.camel@localhost.localdomain>
	<200710111402.12449.sr@denx.de>
	<1192104819.5534.109.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192104819.5534.109.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 07:13:39AM -0500, Josh Boyer wrote:
> On Thu, 2007-10-11 at 14:02 +0200, Stefan Roese wrote:
> > On Thursday 11 October 2007, Josh Boyer wrote:
> > > On Thu, 2007-10-11 at 10:49 +0200, Stefan Roese wrote:
> > > > > > +		PowerPC,405EX@0 {
> > > > > > +			device_type = "cpu";
> > > > > > +			reg = <0>;
> > > > > > +			clock-frequency = <0>; /* Filled in by U-Boot */
> > > > >
> > > > > Filled in by U-Boot itself?  Or by a cuboot wrapper? (which I can't
> > > > > find in the patches.)
> > > >
> > > > By U-Boot itself. I have a U-Boot patch in the queue to add device tree
> > > > support for 4xx. Therefor I don't plan adding a cuboot wrapper for
> > > > Kilauea.
> > >
> > > Very cool!
> > 
> > You can take a look at the kilauea-405ex branch of my 4xx custodian repository 
> > for a latest development snapshort:
> > 
> > http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot/u-boot-ppc4xx.git;a=shortlog;h=kilauea-405ex
> 
> Ok, so how does the DTS file from the kernel get to U-Boot?  Since there
> is no defconfig provided and no wrapper bits, I'm assuming this port
> takes a raw uImage.  Is that correct?  If so, do you expect a separate
> DTB file to be built for this that is passed to U-Boot?

I believe current standard practice is to bulid dtb aware u-boot
images by pointing at dts files from the kernel tree.  u-boot doesn't
have it's own repository of dts files.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
