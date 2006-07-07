Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCB1467B71
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:21 +1000 (EST)
Message-Id: <20060707165534.068499000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/12] aoa: layout fabric: add missing module aliases
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The layout fabric gained support for all IDs when I extracted those from the
OSX description file. But apparently I had forgotten to add them all as
module aliases so the module will also load. This patch adds them.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-07 18:10:26.510223603 +0200
+++ linux-2.6-fetch/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-07-07 18:12:09.690223603 +0200
@@ -77,24 +77,39 @@ struct layout {
 	int pcmid;
 };
 
+MODULE_ALIAS("sound-layout-36");
 MODULE_ALIAS("sound-layout-41");
 MODULE_ALIAS("sound-layout-45");
+MODULE_ALIAS("sound-layout-47");
+MODULE_ALIAS("sound-layout-48");
+MODULE_ALIAS("sound-layout-49");
+MODULE_ALIAS("sound-layout-50");
 MODULE_ALIAS("sound-layout-51");
+MODULE_ALIAS("sound-layout-56");
+MODULE_ALIAS("sound-layout-57");
 MODULE_ALIAS("sound-layout-58");
 MODULE_ALIAS("sound-layout-60");
 MODULE_ALIAS("sound-layout-61");
+MODULE_ALIAS("sound-layout-62");
 MODULE_ALIAS("sound-layout-64");
 MODULE_ALIAS("sound-layout-65");
+MODULE_ALIAS("sound-layout-66");
+MODULE_ALIAS("sound-layout-67");
 MODULE_ALIAS("sound-layout-68");
 MODULE_ALIAS("sound-layout-69");
 MODULE_ALIAS("sound-layout-70");
 MODULE_ALIAS("sound-layout-72");
+MODULE_ALIAS("sound-layout-76");
 MODULE_ALIAS("sound-layout-80");
 MODULE_ALIAS("sound-layout-82");
 MODULE_ALIAS("sound-layout-84");
 MODULE_ALIAS("sound-layout-86");
+MODULE_ALIAS("sound-layout-90");
 MODULE_ALIAS("sound-layout-92");
+MODULE_ALIAS("sound-layout-94");
 MODULE_ALIAS("sound-layout-96");
+MODULE_ALIAS("sound-layout-98");
+MODULE_ALIAS("sound-layout-100");
 
 /* onyx with all but microphone connected */
 static struct codec_connection onyx_connections_nomic[] = {

--
