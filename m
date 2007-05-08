Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 13:09:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] Device tree aware EMAC driver
Message-ID: <20070508030903.GE11340@localhost.localdomain>
References: <20070508025832.GD11340@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508025832.GD11340@localhost.localdomain>
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
the Axon bridge.  Tweaked to build on current kernels.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Too big for the list, download from :
	http://ozlabs.org/~dgibson/home/tmp/powerpc-emac-new

 arch/powerpc/platforms/cell/Kconfig |    4 
 drivers/net/Kconfig                 |   71 
 drivers/net/Makefile                |    1 
 drivers/net/ibm_emac/Kconfig        |   63 
 drivers/net/ibm_newemac/Kconfig     |   55 
 drivers/net/ibm_newemac/Makefile    |   11 
 drivers/net/ibm_newemac/core.c      | 2912 ++++++++++++++++++++++++++++++++++++
 drivers/net/ibm_newemac/core.h      |  354 ++++
 drivers/net/ibm_newemac/debug.c     |  238 ++
 drivers/net/ibm_newemac/debug.h     |   78 
 drivers/net/ibm_newemac/emac.h      |  268 +++
 drivers/net/ibm_newemac/mal.c       |  730 +++++++++
 drivers/net/ibm_newemac/mal.h       |  276 +++
 drivers/net/ibm_newemac/phy.c       |  373 ++++
 drivers/net/ibm_newemac/phy.h       |   80 
 drivers/net/ibm_newemac/rgmii.c     |  324 ++++
 drivers/net/ibm_newemac/rgmii.h     |   76 
 drivers/net/ibm_newemac/tah.c       |  174 ++
 drivers/net/ibm_newemac/tah.h       |   90 +
 drivers/net/ibm_newemac/zmii.c      |  324 ++++
 drivers/net/ibm_newemac/zmii.h      |   73 
 21 files changed, 6514 insertions(+), 61 deletions(-)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
