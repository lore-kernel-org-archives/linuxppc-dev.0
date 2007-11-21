Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Nov 2007 09:28:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
Message-ID: <20071121222822.GB19445@localhost.localdomain>
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<474447EF.8080405@freescale.com>
	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>
	<20071121173540.GC4413@loki.buserror.net>
	<8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>
	<47448687.6010106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47448687.6010106@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 21, 2007 at 01:27:03PM -0600, Scott Wood wrote:
> Kumar Gala wrote:
> > On Nov 21, 2007, at 11:35 AM, Scott Wood wrote:
> >> A cell-index property would be useful here for indexing into the summary
> >> status register.
> > 
> > Divide by 0x80.
> 
> :-P
> 
> Using cell-index for things like this is reasonably common, and endorsed 
> by current ePAPR drafts.

Indeed, indexing or writing into shared registers is exactly what
cell-index is for.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
