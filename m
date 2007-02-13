Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Feb 2007 17:09:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
Message-ID: <20070213060904.GA6214@localhost.localdomain>
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

Here is a preliminary set of patches implementing support for the
440GP based Ebony evaluation board in arch/powerpc.  A number of the
earlier patches are in Paul's queue already, so may appear in
powerpc.git at any point.  Most of the later ones need at least some
cleanup or reworking before they'll be ready for merging.

With these patches I can boot to a shell prompt on initrd on my Ebony
board.  There are still a bunch of problems: clock timings are way out
(runs about 4* fast), things freeze up when I attempt to use an
nfsroot, many devices aren't supported.  A lot of things are hardcoded
in the device tree, so you may well have to tweak it if your Ebony is
different from mine.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
