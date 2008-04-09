Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 43620DDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:42:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 6ED31130D7E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 00:42:16 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90EVQXK-noQB for <linuxppc-dev@ozlabs.org>;
	Thu, 10 Apr 2008 00:42:14 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 8B0A2130CFD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 00:42:14 +0200 (CEST)
Date: Thu, 10 Apr 2008 00:42:14 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fsl_soc : add support for m41t81 rtc chip
Message-ID: <20080409224214.GA1456@frolo.macqel>
References: <20080409222252.GA1006@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080409222252.GA1006@frolo.macqel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello everybody,

Here is small patch allowing to use a m41t81 rtc chip on a FSL_SOC based
board.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

--

I have removed the ifdef as pointed by Olof

--- a/arch/powerpc/sysdev/fsl_soc.c	2008-03-21 14:53:41.000000000 +0000
+++ b/arch/powerpc/sysdev/fsl_soc.c	2008-03-26 12:08:25.000000000 +0000
@@ -405,7 +405,8 @@
 	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
 	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
 	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
+	{"stm,m41t81",     "rtc-m41t80",  "m41t81"},
 	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
