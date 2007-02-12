Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5980EDDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:09:23 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1CL9CWL011378
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 16:09:12 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1CL9CSs449614
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:09:12 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1CL9Ck5012293
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 14:09:12 -0700
Subject: Re: [PATCH 18/19] bootwrapper: Add xlate_reg(), and use it to find
	serial registers.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <45D09993.9050903@freescale.com>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230145.GR3849@ld0162-tx32.am.freescale.net>
	<20070209230700.GC12035@mag.az.mvista.com>
	<45D09993.9050903@freescale.com>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 15:10:15 -0600
Message-Id: <1171314615.4003.27.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 10:45 -0600, Scott Wood wrote:
> Mark A. Greer wrote:
> > On Wed, Feb 07, 2007 at 05:01:45PM -0600, Scott Wood wrote:
> > 
> >>xlate_reg() uses the ranges properties of a node's parentage to find the
> >>absolute physical address of the node's registers.
> >>
> >>The ns16550 driver uses this when no virtual-reg property is found.
> > 
> > 
> > Is this necessary?  Shouldn't there always be a virtual-reg?
> 
> None of the dts files in the kernel tree currently have such a property...

4xx will use this.  The bootwrapper will use the UART mapping setup by
the firmware to print out to the console.  At least that is why it was
added to being with, and how I had it working on Ebony a while ago.
David may have changed it since.

josh
