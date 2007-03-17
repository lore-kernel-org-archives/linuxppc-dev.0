Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:28:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 09/17] bootwrapper: Add dt_set_cpu_clocks().
Message-ID: <20070317012824.GG3969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172851.GI29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172851.GI29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:28:51PM -0500, Scott Wood wrote:
> This adds a library function that platform files can call to
> set clock-frequency, bus-frequency, and timebase-frequency in
> each CPU node.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

And my patch-in-progress had a function almost exactly like this one,
too.  However, not all systems have a notion of "bus-frequency" in the
cpu node, so better make that one optional (I suggest skip the setprop
if bus==0).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
