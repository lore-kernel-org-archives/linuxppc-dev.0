Return-Path: <f.fainelli@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E7381A0814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:39:08 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id g10so1748658pdj.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:06 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH RESEND net-next 2/9] Documentation: devicetree: net: refer to
 fixed-link.txt
Date: Wed, 21 May 2014 14:38:44 -0700
Message-Id: <1400708331-18088-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the Freescale TSEC PHY, Broadcom GENET & SYSTEMPORT Device Tree
binding documentation to refer to the fixed-link Device Tree binding in
fixed-link.txt.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt   | 2 +-
 Documentation/devicetree/bindings/net/broadcom-systemport.txt | 2 +-
 Documentation/devicetree/bindings/net/fsl-tsec-phy.txt        | 5 +----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt b/Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt
index f2febb94550e..451fef26b4df 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bcmgenet.txt
@@ -24,7 +24,7 @@ Optional properties:
 - fixed-link: When the GENET interface is connected to a MoCA hardware block or
   when operating in a RGMII to RGMII type of connection, or when the MDIO bus is
   voluntarily disabled, this property should be used to describe the "fixed link".
-  See Documentation/devicetree/bindings/net/fsl-tsec-phy.txt for information on
+  See Documentation/devicetree/bindings/net/fixed-link.txt for information on
   the property specifics
 
 Required child nodes:
diff --git a/Documentation/devicetree/bindings/net/broadcom-systemport.txt b/Documentation/devicetree/bindings/net/broadcom-systemport.txt
index 1b7600e022dd..c183ea90d9bc 100644
--- a/Documentation/devicetree/bindings/net/broadcom-systemport.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-systemport.txt
@@ -8,7 +8,7 @@ Required properties:
 - local-mac-address: Ethernet MAC address (48 bits) of this adapter
 - phy-mode: Should be a string describing the PHY interface to the
   Ethernet switch/PHY, see Documentation/devicetree/bindings/net/ethernet.txt
-- fixed-link: see Documentation/devicetree/bindings/net/fsl-tsec-phy.txt for
+- fixed-link: see Documentation/devicetree/bindings/net/fixed-link.txt for
   the property specific details
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 737cdef4f903..be6ea8960f20 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -42,10 +42,7 @@ Properties:
     interrupt.  For TSEC and eTSEC devices, the first interrupt is
     transmit, the second is receive, and the third is error.
   - phy-handle : See ethernet.txt file in the same directory.
-  - fixed-link : <a b c d e> where a is emulated phy id - choose any,
-    but unique to the all specified fixed-links, b is duplex - 0 half,
-    1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no
-    pause, 1 pause, e is asym_pause - 0 no asym_pause, 1 asym_pause.
+  - fixed-link : See fixed-link.txt in the same directory.
   - phy-connection-type : See ethernet.txt file in the same directory.
     This property is only really needed if the connection is of type
     "rgmii-id", as all other connection types are detected by hardware.
-- 
1.9.1
