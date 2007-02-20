Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Feb 2007 13:08:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [0/14] Ebony support, 2nd spin
Message-ID: <20070220020837.GF17818@localhost.localdomain>
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

Here is a 2nd spin of my patch series adding support for the Ebony
440GP evaluation board to the arch/powerpc tree.  Notable changes from
the last spin:

	- I no longer use legacy_serial for the serial ports and
	  console, instead I'm using Arnd's of_serial system.
	- Rebased on my recent clean/flexibility patches for the
	  zImage loader
	- Includes a general re-orgranization of the arch/powerpc
	  Kconfig code for 4xx, allowing a kernel to support multiple
	  boards at once (well, in theory, Ebony is the only supported
	  one so far).
	- The early serial hacks no longer use an entire 64-bit
	  constant, so should work on non-64-bit aware assemblers

Again, some of the earlier patches I'm about to push to Paulus or
others, so they could appear in upstream trees.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
