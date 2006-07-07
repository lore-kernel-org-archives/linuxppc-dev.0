Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07A2D67B5E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:18:43 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: snd-aoa: Add sound-layout-36 alias
Date: Fri, 07 Jul 2006 19:18:28 +0200
Message-ID: <jed5chjpuj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.17-git13/sound/aoa/fabrics/snd-aoa-fabric-layout.c
===================================================================
--- linux-2.6.17-git13.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-06-29 00:59:52.000000000 +0200
+++ linux-2.6.17-git13/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-06-29 01:06:02.000000000 +0200
@@ -77,6 +77,7 @@ struct layout {
 	int pcmid;
 };
 
+MODULE_ALIAS("sound-layout-36");
 MODULE_ALIAS("sound-layout-41");
 MODULE_ALIAS("sound-layout-45");
 MODULE_ALIAS("sound-layout-51");

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
