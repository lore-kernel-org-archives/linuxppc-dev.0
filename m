Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84647DDF5B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 14:06:58 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9B476RZ003164
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 14:07:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9B46uZL4559016
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 14:06:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9B4434n005934
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 14:04:04 +1000
Date: Thu, 11 Oct 2007 14:06:22 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
Message-ID: <20071011040622.GE14873@localhost.localdomain>
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
	<fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 08:25:36PM -0600, Grant Likely wrote:
> On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > On Wed, Oct 10, 2007 at 03:38:02PM -0500, Josh Boyer wrote:
[snip]
> > > "number" seems a bit to generic to me.  logical-number seems a bit more
> > > descriptive.
> >
> > We've used 'cell-index' for similar purposes on other 4xx.
> 
> Unfortunately, 'cell' has been used in the sense of a logic cell in an
> SoC.  In the case of the SystemACE, it is an external chip.
> 
> What about "device-number"?

Ok, I misunderstood.  If it's not on chip, what significance does this
serial number have?  Where would a driver need it?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
