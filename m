Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 051C6679F8
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 01:46:48 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3AFkkdm014641
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 11:46:46 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3AFhIne250232
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 09:43:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3AFkjm2025878
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 09:46:45 -0600
Date: Mon, 10 Apr 2006 10:39:29 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: paulus@samba.org
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
Message-Id: <20060410103929.9664238d.moilanen@austin.ibm.com>
In-Reply-To: <20060401165723.ab77c81f.moilanen@austin.ibm.com>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
	<17454.15223.929530.985654@cargo.ozlabs.ibm.com>
	<20060401165723.ab77c81f.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Apr 2006 16:57:23 -0600
Jake Moilanen <moilanen@austin.ibm.com> wrote:

> On Sat, 1 Apr 2006 19:36:07 +1100
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Jake Moilanen writes:
> > 
> > > The NR_IRQS got bumped up to 1024, as vectors can go much higher.
> > > Unfortunately, this number was arbitrarily picked as there is no claim
> > > at what the max number really is by either the firmware team, or the
> > > PAPR+.
> > 
> > What matters is the number of different vectors, not the actual value
> > of the vectors, because we remap interrupt numbers that the firmware
> > gives us to logical Linux irq numbers between 0 and NR_IRQS-1.  We had
> > to do that when the POWER5 systems came out, because the interrupt
> > numbers there occupy 24 bits.
> 
> Ah.  That sounds right.  I haven't had a chance to test this version of
> the patch.  Firmware is currently broken on my machine.

I was able to validate that these patches do work, and we are receiving
MSI interrupts correctly.

Is it too late to get into 2.6.17?

Jake
