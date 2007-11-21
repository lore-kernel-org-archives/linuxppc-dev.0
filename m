Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B997DDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 00:21:56 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALDLrVn011142
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:21:53 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALDLqoq129492
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:21:52 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALDLqHX007775
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:21:52 -0700
Date: Wed, 21 Nov 2007 07:21:51 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 13/14] powerpc: EP405 boards support for arch/powerpc
Message-ID: <20071121072151.01156349@weaponx>
In-Reply-To: <20071121061721.8497FDEBFC@ozlabs.org>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061721.8497FDEBFC@ozlabs.org>
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

On Wed, 21 Nov 2007 17:16:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Brings EP405 support to arch/powerpc. The IRQ routing for the CPLD
> comes from a device-tree property, PCI is working to the point where
> I can see the video card, USB device, and south bridge.
> 
> This should work with both EP405 and EP405PC.
> 
> I've not totally figured out how IRQs are wired on this hardware
> though, thus at this stage, expect only USB interrupts working,
> pretty much the same as what arch/ppc did.
> 
> Also, the flash, nvram, rtc and temp control still have to be wired.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

<snip>

> Index: linux-work/arch/powerpc/boot/dts/ep405.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/boot/dts/ep405.dts	2007-11-21 16:23:03.000000000 +1100
> @@ -0,0 +1,221 @@
> +/*
> + * Device Tree Source for EP405
> + *
> + * Copyright 2007 IBM Corp.
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>

Hm... odd.  I don't remember writing this device tree ;)

josh
