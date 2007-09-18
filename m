Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80067DDEF7
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 03:28:59 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8IHRqPa031093
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 21:27:52 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8IHRqjD031090
	for linuxppc-dev@ozlabs.org; Tue, 18 Sep 2007 21:27:52 +0400
Date: Tue, 18 Sep 2007 21:27:52 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] PowerPC: Fix Bamboo MAL0 dts entry.
Message-ID: <20070918172752.GA31070@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918172510.GA30944@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to PowerPC 440EP documentation,
MAL0 consists of 6 channels (4 transmit channels and 2 receive channels)
This patch fixes Bamboo DTS MAL0 "num-rx-chans" entry.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/bamboo.dts |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -ruN linux-2.6.orig/arch/powerpc/boot/dts/bamboo.dts linux-2.6/arch/powerpc/boot/dts/bamboo.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/bamboo.dts	2007-09-18 15:32:18.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/bamboo.dts	2007-09-18 21:08:55.000000000 +0400
@@ -94,7 +94,7 @@
 			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
 			dcr-reg = <180 62>;
 			num-tx-chans = <4>;
-			num-rx-chans = <4>;
+			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
 			interrupts = <0 1 2 3 4>;
 			#interrupt-cells = <1>;
