Return-Path: <dgibson@ozlabs.org>
Date: Wed, 30 May 2007 16:17:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Device tree aware EMAC driver
Message-ID: <20070530061740.GB30491@localhost.localdomain>
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

This is BenH's rewritten, device tree aware driver for the IBM/AMCC
EMAC, ethernet MAC controller ASIC found on various 4xx CPUs and also
the Axon bridge.
	- Updated to build on current kernels
	- Removed device_type matching requirement on MAL and ZMII, to
match current best practice of omitting device_type unless a
well-defined class binding exists.
	- Added documentation to booting-without-of.txt for the EMAC
binding.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Download from:

http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070530.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
