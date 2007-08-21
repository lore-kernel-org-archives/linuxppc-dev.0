Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 13:33:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 07/20] bootwrapper: Add TARGET_HAS_ETHn tests to ppcboot.h.
Message-ID: <20070821033306.GV15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173952.GF30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173952.GF30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:39:52PM -0500, Scott Wood wrote:
> U-boots more recent than when ppcboot.h was forked allow the board config
> file to enable additional ethernet ports explicitly, rather than
> using a hardcoded list of targets.  This allows bootwrapper platform
> files to do the same.
> 
> Fortunately, nothing after the ethernet addresses is of interest to
> cuboot platforms, so the inevitable mismatches won't be too
> catastrophic.

Good grief.  Increases my already considerable wonderment at the fact
that anyone ever thought bd_t was an acceptable way of passing data to
the OS.
 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

I can't say I'm thrilled at having two basically incompatible ways of
specifying the layout of this vital structure, but bd_t is so fscked
by design anyway, what's one more hack for convenience.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
