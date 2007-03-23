Return-Path: <dgibson@ozlabs.org>
Date: Fri, 23 Mar 2007 16:25:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/6] bootwrapper: Add support for cuboot platforms.
Message-ID: <20070323052540.GB6199@localhost.localdomain>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194924.GC31965@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194924.GC31965@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 22, 2007 at 02:49:24PM -0500, Scott Wood wrote:
> Platforms beginning with "cuboot" have the bootwrapper code built in,
> unlike the regular uboot platform.

I think 3, 4 and 5 of this series should be merged into a single
patch.  They're not much use without each other.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
