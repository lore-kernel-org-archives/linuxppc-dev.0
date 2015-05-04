Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 76B941A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 23:40:58 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: [PATCH v4 3/3] Documentation: mmc: Update Arasan SDHC documentation
 to support 4.9a version of Arasan SDHC controller.
Date: Mon,  4 May 2015 19:09:52 +0530
Message-Id: <1430746792-32574-4-git-send-email-stripathi@apm.com>
In-Reply-To: <1430746792-32574-1-git-send-email-stripathi@apm.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org,
 patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates Arasan SDHC documentation to support
4.9a version of Arasan SDHC controller.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 98ee2ab..6dd3d60 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

 Required Properties:
-  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
+  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
+                'arasan,sdhci-4.9a'
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
--
1.8.2.1
