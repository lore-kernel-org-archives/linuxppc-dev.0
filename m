Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 10:42:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Message-ID: <20070321234226.GB2295@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172848.GG29784@ld0162-tx32.am.freescale.net>
	<20070317012654.GE3969@localhost.localdomain>
	<c01196ee10aa2b13278465a835a49fdf@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c01196ee10aa2b13278465a835a49fdf@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 02:32:55PM +0100, Segher Boessenkool wrote:
> > However, #address-cells=2, #size-cells=1 is common enough that we
> > really need to support that case.
> 
> On the root node?!?  Who would do such a strange thing?

Ebony, for one, it works nicely for a 32-bit system with >32-bit bus.
Apple G5s do it too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
