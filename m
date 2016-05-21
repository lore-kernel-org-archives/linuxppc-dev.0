Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBjX23Yg3zDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 21:39:46 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id t6so43896lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 04:39:45 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, dt@kernel.org, pawel.moll@arm.com,
 mark.rutland@arm.com, devicetree@hellion.org.uk, galak@codeaurora.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 sudeep.holla@arm.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0030/1529] Fix typo
Date: Sat, 21 May 2016 13:39:34 +0200
Message-Id: <20160521113934.453-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/devicetree/bindings/rtc/rtc-opal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-opal.txt b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
index a1734e5..2340938c 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-opal.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
@@ -2,7 +2,7 @@ IBM OPAL real-time clock
 ------------------------
 
 Required properties:
-- comapatible: Should be "ibm,opal-rtc"
+- compatible: Should be "ibm,opal-rtc"
 
 Optional properties:
 - wakeup-source: Decides if the wakeup is supported or not
-- 
2.8.2.534.g1f66975
