Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4576DDDF8A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 20:10:59 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l279AsdG002588
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 04:10:54 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l279Arvo270686
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 04:10:53 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l279Ar52012928
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 04:10:53 -0500
Date: Wed, 7 Mar 2007 14:40:26 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070307091026.GJ7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<20070306220546.GI24926@localdomain>
	<1173257567.9349.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173257567.9349.27.camel@localhost.localdomain>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>, fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 09:52:47AM +0100, Benjamin Herrenschmidt wrote:
> On Tue, 2007-03-06 at 16:05 -0600, Nathan Lynch wrote:
> > Was the root cause of this problem ever determined?  It sure looked
> > like a firmware or hardware problem since it's known to occur only on
> > JS20.
> 
> js20 and js21 have in common that the firmware "emulates" the XICS on
> top of an MPIC, which can cause interesting issues ... like the
> requirement of issuing EOI's from the CPU that got the interrupt, among
> ohters.
>

There is no interrupt missing problems in JS21. Only JS20 boxes face this
problem. The only difference between JS20 and JS21 is that JS20 does not
have Global Interrupt Queue while JS21 has GIQ.

Regards,
Mohan.
