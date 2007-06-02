Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C628EDDE02
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 17:40:14 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <7fc919fce0761f861be3069a853d3169@bga.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 17:39:52 +1000
Message-Id: <1180769992.14025.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 23:30 -0500, Milton Miller wrote:
> 
> Actually, looking back at your device tree {1], your list several
> properties for flash, including bank-width and partition names.
> Perhaps first compatible should be direct-mapped-partitioned-flash,
> direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
> direct-mapped-rom driver would expose one section of address space
> read-only). I'm assuming that your driver for this "direct-mapped"
> device will look at these properties from the of device node and
> call the mtd layer somewhat directly with their contents. 

If it's a flash, compatible should be the chip type, and maybe as a
second entry, what type of flash protocol (amd, intel, cfi, ...) it's
compatible.

Ben.
