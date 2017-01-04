Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0042.outbound.protection.outlook.com [104.47.36.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttnxb3HDGzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 22:04:02 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <oss@buserror.net>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] dt-bindings: qman: Remove pool channel node
Date: Wed, 4 Jan 2017 13:03:49 +0200
Message-ID: <1483527829-8369-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

From: Scott Wood <oss@buserror.net>

No device tree has these, nor does any driver look for them.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 .../devicetree/bindings/soc/fsl/qman-portals.txt     | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
index 47e46cc..5a34f3a 100644
--- a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
@@ -5,7 +5,6 @@ Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
 CONTENTS
 
 	- QMan Portal
-	- QMan Pool Channel
 	- Example
 
 QMan Portal Node
@@ -82,25 +81,6 @@ These subnodes should have the following properties:
 	Definition:	The phandle to the particular hardware device that this
 			portal is connected to.
 
-DPAA QMan Pool Channel Nodes
-
-Pool Channels are defined with the following properties.
-
-PROPERTIES
-
-- compatible
-	Usage:		Required
-	Value type:	<stringlist>
-	Definition:	Must include "fsl,qman-pool-channel"
-			May include "fsl,<SoC>-qman-pool-channel"
-
-- fsl,qman-channel-id
-	Usage:		Required
-	Value type:	<u32>
-	Definition:	The hardware index of the channel. This can also be
-			determined by dividing any of the channel's 8 work queue
-			IDs by 8
-
 EXAMPLE
 
 The example below shows a (P4080) QMan portals container/bus node with two portals
-- 
2.1.0
