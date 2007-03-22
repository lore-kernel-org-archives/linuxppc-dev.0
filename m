Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 17:06:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/10] arch/powerpc Ebony support (draft 3)
Message-ID: <20070322060630.GB16993@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's my latest stack of Ebony patches.  Not yet ready for merging,
but getting closer.  Notable changes:
	- Rebased on top of my latest set of zImage patches (which in
turn are based on some of Milton and Scott's zImage work)
	- Device tree now contains rudimentary information on the EBC
and the Ebony's off-chip devices
	- Reset support is now folded in, rather than a distinct patch
in the series.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
