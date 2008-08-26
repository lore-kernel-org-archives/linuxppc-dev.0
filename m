Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Aug 2008 10:41:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Brunner <super.firetwister@googlemail.com>
Subject: Re: [PATCH] add a simple 405EP based board
Message-ID: <20080826004121.GA13658@yookeroo.seuss>
References: <200808211007.59965.super.firetwister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200808211007.59965.super.firetwister@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 10:07:58AM +0200, Markus Brunner wrote:
> This adds support for a simple ppc405ep board. 
> At the moment, there are no 405ep boards in arch/powerpc, so this can be used as a template
> for new boards, or migrating them from arch/ppc.
> I2c, UART and EMAC are working. PCI could not be tested, so it was not included in the dts.
> 
> Signed-off-by: Markus Brunner <super.firetwister@googlemail.com>

[snip]
> +			EMAC0: ethernet@ef600800 {
> +				linux,network-index = <0>;

The network-index property is obsolete, you shouldn't need it any
more.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
