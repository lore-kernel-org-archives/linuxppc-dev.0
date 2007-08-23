Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41EABDDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 03:33:27 +1000 (EST)
Date: Thu, 23 Aug 2007 12:33:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070823173314.GA18412@ld0162-tx32.am.freescale.net>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<20070823024757.GC7042@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070823024757.GC7042@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2007 at 12:47:57PM +1000, David Gibson wrote:
> > ./drivers/mtd/maps/tqm834x.c:#include <asm/ppcboot.h>
> > ./drivers/mtd/maps/pq2fads.c:#include <asm/ppcboot.h>
> 
> Although these both have an extern of type bd_t (defined in
> ppcboot.h), afaict they don't actually use it, so these should be
> removable.

They look like they're using it to me...  See the bd->bi_flashstart and
bd->bi_flashsize references in init_pq2fads_mtd.

-Scott
