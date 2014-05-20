Return-Path: <f.fainelli@gmail.com>
Received: from mail-yh0-x231.google.com (mail-yh0-x231.google.com
 [IPv6:2607:f8b0:4002:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96FA31A0829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 10:57:04 +1000 (EST)
Received: by mail-yh0-f49.google.com with SMTP id c41so7534052yho.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 17:57:01 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/9] Documentation: devicetree: add old and
 deprecated 'fixed-link'
Date: Mon, 19 May 2014 17:56:16 -0700
Message-Id: <1400547384-11363-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
References: <1400547384-11363-1-git-send-email-f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Grant Likely <grant.likely@linaro.org>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 davem@davemlof.net, Vitaly Bordug <vbordug@ru.mvista.com>,
 Kumar Gala <galak@codeaurora.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
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
 Documentation/devicetree/bindings/net/fixed-link.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fixed-link.txt b/Documentation/devicetree/bindings/net/fixed-link.txt
index e956de1be935..34a991eb213f 100644
--- a/Documentation/devicetree/bindings/net/fixed-link.txt
+++ b/Documentation/devicetree/bindings/net/fixed-link.txt
@@ -18,6 +18,18 @@ properties:
 * 'asym-pause' (boolean, optional), to indicate that asym_pause should
   be enabled.
 
+Old, deprecated 'fixed-link' binding:
+
+* A 'fixed-link' property in the Ethernet MAC node, with 5 cells, of the
+  form <a b c d e> with the following accepted values:
+  - a: emulated phy id, choose any but but unique to the all specified
+    fixed-links, from 0 to 31
+  - b: duplex configuration: 0 for half duplex, 1 for full duplex
+  - c: link speed in Mbits/sec, accepted values are: 10, 100 and 1000
+  - d: pause configuration: 0 for no pause, 1 for pause
+  - e: asymetric pause configuration: 0 for no asymetric pause, 1 for asymetric
+    pause
+
 Example:
 
 ethernet@0 {
-- 
1.9.1
