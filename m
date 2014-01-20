Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id EA6592C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 06:43:56 +1100 (EST)
Date: Mon, 20 Jan 2014 19:43:50 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Paul Bolle <pebolle@tiscali.nl>,
 Michael Ellerman <michael@ellerman.id.au>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/kconfig: Remove TSI108_BRIDGE duplicates
Message-ID: <20140120194344.GA5816@hercules>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPC7448HPC2 and PPC_HOLLY config options contain TSI108_BRIDGE
duplicates since commit:

commit 3490cba56f7f8a78ef4c94814c3181f09ce1e2ef
Author: Jon Loeliger <jdl@jdl.com>
Date:   Wed Jan 23 12:42:50 2008 -0600

    [POWERPC] Add initial iomega StorCenter board port.

This patch cleans these duplicates.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/platforms/embedded6xx/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 302ba43..59bd9cd 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -34,7 +34,6 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
-	select TSI108_BRIDGE
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
@@ -44,7 +43,6 @@ config PPC_HOLLY
 	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
-	select TSI108_BRIDGE
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
-- 
1.8.3.2

Cheers,
--
Luis
