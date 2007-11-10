Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B615DDF40
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 11:17:54 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAA0HoKP021891
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 19:17:50 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAA0Ho22075224
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 19:17:50 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAA0HnK6011616
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 19:17:49 -0500
Subject: Re: On-going 4xx porting
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20071110024813.5cada553@kernel.crashing.org>
References: <1194645701.3207.17.camel@localhost.localdomain>
	<20071110024813.5cada553@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 18:17:22 -0600
Message-Id: <1194653842.3207.20.camel@localhost.localdomain>
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

On Sat, 2007-11-10 at 02:48 +0300, Vitaly Bordug wrote:
> On Fri, 09 Nov 2007 16:01:41 -0600
> Josh Boyer wrote:
> 
> > Hi All,
> > 
> > For those interested, I have a few things I'd like to focus on for
> > 2.6.25 in regards to the current arch/powerpc 4xx porting effort.
> > Below is a brief list of drivers in no particular order:
> > 
> > PCI support
> I'll look at that stuff once again. maybe it worths to head fir compromise solution in favor of replacing 32/64 
> ranges parsing func + a bunch of other things in one single step.

Sure, that's fine.  You and Ben were working on it at one point, so I
figured you would look at it again.

> > USB (440EP(x), etc)
> looks like we have code ready for that...

It's mostly there, yes.  Should be pretty easy to get in :).

> > I2C
> Stefan's approach seems pretty close

Agreed.

> > GPIO
> > NDFC
> I'd rather follow platform device wrapper way.. Big NDFC of_device rework can be done anytime later.

I would seriously consider that too.

josh
