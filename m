Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8410ADDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 21:53:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BBrrkS004014
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 07:53:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BBrre9477036
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 07:53:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BBrrhB012956
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 07:53:53 -0400
Subject: Re: [PATCH 3/3] [POWERPC] Kilauea DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200710111049.02253.sr@denx.de>
References: <200710081110.16447.sr@denx.de>
	<1192047714.5534.81.camel@localhost.localdomain>
	<200710111049.02253.sr@denx.de>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 06:51:38 -0500
Message-Id: <1192103498.5534.101.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 10:49 +0200, Stefan Roese wrote:
> > > +		PowerPC,405EX@0 {
> > > +			device_type = "cpu";
> > > +			reg = <0>;
> > > +			clock-frequency = <0>; /* Filled in by U-Boot */
> >
> > Filled in by U-Boot itself?  Or by a cuboot wrapper? (which I can't find
> > in the patches.)
> 
> By U-Boot itself. I have a U-Boot patch in the queue to add device tree 
> support for 4xx. Therefor I don't plan adding a cuboot wrapper for Kilauea.

Very cool!

> > > +				interrupt-parent = <&UIC1>;
> > > +
> > > +				nor_flash@0,0 {
> >
> > You have no ranges property for the ebc parent node.  Is if filled in by
> > U-Boot?  If so, please add a comment because otherwise I don't see how
> > this mapping will work.
> 
> Yes, it's filled in by U-Boot too. I'll add a comment here.

Ok.

> >
> > No chosen node?
> 
> No. U-Boot will provide all needed information here.

Does it provide it by creating the chosen node?  Or by still using the
bd_t method?

josh
