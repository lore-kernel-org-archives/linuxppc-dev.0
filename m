Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 14:53:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/11] ibm_newemac: Skip EMACs that are marked unused by
	the firmware
Message-ID: <20071205035345.GA12855@localhost.localdomain>
References: <20071205001539.97730DE091@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071205001539.97730DE091@ozlabs.org>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 11:14:30AM +1100, Benjamin Herrenschmidt wrote:
> From: Hugh Blemings <hugh@blemings.org>
> 
> Depending on how the 44x processors are wired, some EMAC cells
> might not be useable (and not connected to a PHY). However, some
> device-trees may choose to still expose them (since their registers
> are present in the MMIO space) but with an "unused" property in
> them.

It occurred to me the other day.  Instead of using a new "unused"
property for this, should we be using the OF standard "status"
property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
