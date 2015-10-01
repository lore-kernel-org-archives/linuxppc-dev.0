Return-Path: <claudiu.manoil@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444921A010C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 20:29:52 +1000 (AEST)
From: Claudiu Manoil <claudiu.manoil@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <galak@codeaurora.org>, "David S. Miller"
 <davem@davemloft.net>, Li Yang <leoli@freescale.com>, Zhao Chenhui
 <chenhui.zhao@freescale.com>
Subject: [PATCH 1/3] doc: dt: net: Add fsl,wake-on-filer for eTSEC
Date: Thu, 1 Oct 2015 13:10:01 +0300
Message-ID: <1443694201-29485-1-git-send-email-claudiu.manoil@freescale.com>
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

Add the "fsl,wake-on-filer" property for eTSEC nodes to
indicate that the system has the power management
infrastructure needed to be able to wake up the system
via FGPI (filer, aka. h/w rx parser) interrupt.

Cc: Li Yang <leoli@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
 Documentation/devicetree/bindings/net/fsl-tsec-phy.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 1e97532..db74f0d 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -57,6 +57,10 @@ Properties:
     "rgmii-id", as all other connection types are detected by hardware.
   - fsl,magic-packet : If present, indicates that the hardware supports
     waking up via magic packet.
+  - fsl,wake-on-filer : If present, indicates that the hardware supports
+    waking up by Filer General Purpose Interrupt (FGPI) asserted on the
+    Rx int line.  This is an advanced power management capability allowing
+    certain packet types (user) defined by filer rules to wake up the system.
   - bd-stash : If present, indicates that the hardware supports stashing
     buffer descriptors in the L2.
   - rx-stash-len : Denotes the number of bytes of a received buffer to stash
-- 
1.7.11.7
