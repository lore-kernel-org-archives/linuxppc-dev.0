Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:26:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Message-ID: <20070317012654.GE3969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172848.GG29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172848.GG29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:28:48PM -0500, Scott Wood wrote:
> This adds a library function that platforms can call to fill in the
> /memory node with the specified start and size.  #address-cells and
> #size-cells must be the same, but can be either 1 or 2.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Heh, you read my mind.  I was in the process of making up a patch with
a helper function almost identical to this.

However, #address-cells=2, #size-cells=1 is common enough that we
really need to support that case.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
