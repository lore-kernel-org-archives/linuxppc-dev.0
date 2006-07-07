Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D89567B53
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:17 +1000 (EST)
Message-Id: <20060707165532.006059000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/12] aoa: tas: change PCM1 name to PCM
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the PCM1 control name to PCM to make it play
nice with the softvol plugin (which will then go away if it
sees a proper PCM slider)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 12:15:39.307697157 +0200
+++ linux-2.6-fetch/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 12:15:55.907697157 +0200
@@ -309,7 +309,7 @@ static struct snd_kcontrol_new n##_contr
 	.private_value = idx,				\
 }
 
-MIXER_CONTROL(pcm1, "PCM1", 0);
+MIXER_CONTROL(pcm1, "PCM", 0);
 MIXER_CONTROL(monitor, "Monitor", 2);
 
 static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,

--
