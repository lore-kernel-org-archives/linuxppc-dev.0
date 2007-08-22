Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1ED0DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 02:01:26 +1000 (EST)
Date: Wed, 22 Aug 2007 11:01:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070822160109.GA22307@ld0162-tx32.am.freescale.net>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 10:19:21AM -0500, Kumar Gala wrote:
> ./drivers/mtd/maps/tqm834x.c:#include <asm/ppcboot.h>
> ./drivers/mtd/maps/pq2fads.c:#include <asm/ppcboot.h>

These use the bd_t, and thus will only work on arch/ppc.  On
arch/powerpc, we can use the device tree to specify the mapping.

-Scott
