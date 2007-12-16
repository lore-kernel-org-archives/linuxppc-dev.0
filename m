Return-Path: <dgibson@ozlabs.org>
Date: Sun, 16 Dec 2007 17:27:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] FSL: enet device tree cleanups
Message-ID: <20071216062723.GF21311@localhost.localdomain>
References: <Pine.LNX.4.64.0712120151590.25255@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0712120151590.25255@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 01:52:05AM -0600, Kumar Gala wrote:
> * Removed address fields in ethernet nodes
> * Removed #address-cells, #size-cells from gianfar nodes
> * Added cell-index to gianfar and ucc ethernet nodes
> * Added enet[0..3] labels
> * Renamed compatible node for gianfar mdio to "fsl,gianfar-mdio"
> * Removed device_type = "mdio"

Hurrah!  Finally.  

> The matching for gianfar mdio still supports the old "mdio"/"gianfar" combo
> but it is now considered deprecated.

That's fine.  It's acceptable to keep match list entries for broken
trees around pretty much indefinitely.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
