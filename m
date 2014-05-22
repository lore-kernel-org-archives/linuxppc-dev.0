Return-Path: <f.fainelli@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF2371A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 02:48:16 +1000 (EST)
Received: by mail-ie0-f173.google.com with SMTP id lx4so3814736iec.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 09:48:13 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/9] Documentation: devicetree: add old and
 deprecated 'fixed-link'
Date: Thu, 22 May 2014 09:47:43 -0700
Message-Id: <1400777271-32199-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
References: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
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

Update the fixed-link Device Tree binding documentation to contain
information about the old and deprecated 5-digit 'fixed-link' property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- fixed typos and spelling mistakes as spotted by Sergei

 Documentation/devicetree/bindings/net/fixed-link.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fixed-link.txt b/Documentation/devicetree/bindings/net/fixed-link.txt
index e956de1be935..82bf7e0f47b6 100644
--- a/Documentation/devicetree/bindings/net/fixed-link.txt
+++ b/Documentation/devicetree/bindings/net/fixed-link.txt
@@ -18,6 +18,18 @@ properties:
 * 'asym-pause' (boolean, optional), to indicate that asym_pause should
   be enabled.
 
+Old, deprecated 'fixed-link' binding:
+
+* A 'fixed-link' property in the Ethernet MAC node, with 5 cells, of the
+  form <a b c d e> with the following accepted values:
+  - a: emulated PHY ID, choose any but but unique to the all specified
+    fixed-links, from 0 to 31
+  - b: duplex configuration: 0 for half duplex, 1 for full duplex
+  - c: link speed in Mbits/sec, accepted values are: 10, 100 and 1000
+  - d: pause configuration: 0 for no pause, 1 for pause
+  - e: asymmetric pause configuration: 0 for no asymmetric pause, 1 for
+    asymmetric pause
+
 Example:
 
 ethernet@0 {
-- 
1.9.1
