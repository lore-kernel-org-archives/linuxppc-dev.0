Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDylt4pHJzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 11:43:38 +1100 (AEDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: devicetree@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: powerpc/fsl: Update compatible for l2cache
 binding
Date: Fri,  3 Feb 2017 13:43:16 +1300
Message-Id: <20170203004316.25291-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

List all the current valid compatible strings for the l2cache binding.
This should stop checkpatch.pl from complaining and will hopefully save
someone from having to debug a typo in their dts.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/powerpc/fsl/l2cache.txt    | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
index c41b2187eaa8..dc9bb3182525 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
@@ -5,8 +5,46 @@ The cache bindings explained below are ePAPR compliant
 
 Required Properties:
 
-- compatible	: Should include "fsl,chip-l2-cache-controller" and "cache"
-		  where chip is the processor (bsc9132, npc8572 etc.)
+- compatible	: Should include one of the following:
+		  "fsl,8540-l2-cache-controller"
+		  "fsl,8541-l2-cache-controller"
+		  "fsl,8544-l2-cache-controller"
+		  "fsl,8548-l2-cache-controller"
+		  "fsl,8555-l2-cache-controller"
+		  "fsl,8568-l2-cache-controller"
+		  "fsl,b4420-l2-cache-controller"
+		  "fsl,b4860-l2-cache-controller"
+		  "fsl,bsc9131-l2-cache-controller"
+		  "fsl,bsc9132-l2-cache-controller"
+		  "fsl,c293-l2-cache-controller"
+		  "fsl,mpc8536-l2-cache-controller"
+		  "fsl,mpc8540-l2-cache-controller"
+		  "fsl,mpc8541-l2-cache-controller"
+		  "fsl,mpc8544-l2-cache-controller"
+		  "fsl,mpc8548-l2-cache-controller"
+		  "fsl,mpc8555-l2-cache-controller"
+		  "fsl,mpc8560-l2-cache-controller"
+		  "fsl,mpc8568-l2-cache-controller"
+		  "fsl,mpc8569-l2-cache-controller"
+		  "fsl,mpc8572-l2-cache-controller"
+		  "fsl,p1010-l2-cache-controller"
+		  "fsl,p1011-l2-cache-controller"
+		  "fsl,p1012-l2-cache-controller"
+		  "fsl,p1013-l2-cache-controller"
+		  "fsl,p1014-l2-cache-controller"
+		  "fsl,p1015-l2-cache-controller"
+		  "fsl,p1016-l2-cache-controller"
+		  "fsl,p1020-l2-cache-controller"
+		  "fsl,p1021-l2-cache-controller"
+		  "fsl,p1022-l2-cache-controller"
+		  "fsl,p1023-l2-cache-controller"
+		  "fsl,p1024-l2-cache-controller"
+		  "fsl,p1025-l2-cache-controller"
+		  "fsl,p2010-l2-cache-controller"
+		  "fsl,p2020-l2-cache-controller"
+		  "fsl,t2080-l2-cache-controller"
+		  "fsl,t4240-l2-cache-controller"
+		  and "cache".
 - reg		: Address and size of L2 cache controller registers
 - cache-size	: Size of the entire L2 cache
 - interrupts	: Error interrupt of L2 controller
-- 
2.11.0.24.ge6920cf
