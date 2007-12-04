Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Dec 2007 13:40:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] [v2] Improved documentation of device tree
	'ranges'.
Message-ID: <20071204024025.GG32577@localhost.localdomain>
References: <20071204010818.AD4231798062@mail212-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204010818.AD4231798062@mail212-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, Dec 03, 2007 at 05:08:57PM -0800, Stephen Neuendorffer wrote:
> I was misled by the prior language.  I've attempted to clarify how
> 'ranges' are used, in particular, how to get an identity mapping.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks for the update.  I particularly dislike the "1:1" terminology,
because in maths-speak *any* ranges translation is 1:1, unless it
includes overlapping ranges.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
