Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Feb 2007 12:12:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: EMAC device-tree binding (#2)
Message-ID: <20070202011214.GC3913@localhost.localdomain>
References: <1170118707.26655.299.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170118707.26655.299.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 11:58:27AM +1100, Benjamin Herrenschmidt wrote:
> According to the various comments I got, here's the latest binding for
> EMAC:

[snip]
>  - cell-index        : 1 cell, hardware index of the EMAC cell on a given ASIC (typically
>                        0x00000000 and 0x00000001 for EMAC-0 and EMAC-1 on each Axon chip)

I noticed that some of the Freescale device trees used a property
called 'device-id' for what appears to be the same thing as this on
their UCC.  Maybe we should use that name for EMAC and the other 4xx
devices as well?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
