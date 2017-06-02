Return-Path: <leoyang.li@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0088.outbound.protection.outlook.com [104.47.37.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfgFx6NnBzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 09:21:40 +1000 (AEST)
From: Li Yang <leoyang.li@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 1/2] MAINTAINERS: update entry for Freescale SoC drivers
Date: Fri, 2 Jun 2017 18:20:22 -0500
Message-ID: <1496445623-22390-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add myself as the maintainer for drivers/fsl/soc/ and fix the scope for
device tree bindings.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d24240b..1807d3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5357,11 +5357,11 @@ S:	Maintained
 F:	drivers/net/ethernet/freescale/dpaa
 
 FREESCALE SOC DRIVERS
-M:	Scott Wood <oss@buserror.net>
+M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/powerpc/fsl/
+F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
 
@@ -7695,6 +7695,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 S:	Maintained
 F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
+F:	Documentation/devicetree/bindings/powerpc/fsl/
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
 L:	linuxppc-dev@lists.ozlabs.org
-- 
1.9.0
