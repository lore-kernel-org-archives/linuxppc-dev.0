Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB5BE67C3E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:11:47 +1000 (EST)
Message-Id: <20060607130916.954103000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Date: Wed, 07 Jun 2006 15:09:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 09/12] snd-aoa: add build files for codecs
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the Makefile and Kconfig file for the codecs
that were added in the previous patches.

--- /dev/null
+++ b/sound/aoa/codecs/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SND_AOA_ONYX) += snd-aoa-codec-onyx.o
+obj-$(CONFIG_SND_AOA_TAS) += snd-aoa-codec-tas.o
+obj-$(CONFIG_SND_AOA_TOONIE) += snd-aoa-codec-toonie.o
--- /dev/null
+++ b/sound/aoa/codecs/Kconfig
@@ -0,0 +1,32 @@
+config SND_AOA_ONYX
+	tristate "support Onyx chip"
+	depends on SND_AOA
+	---help---
+	This option enables support for the Onyx (pcm3052)
+	codec chip found in the latest Apple machines
+	(most of those with digital audio output).
+
+#config SND_AOA_TOPAZ
+#	tristate "support Topaz chips"
+#	depends on SND_AOA
+#	---help---
+#	This option enables support for the Topaz (CS84xx)
+#	codec chips found in the latest Apple machines,
+#	these chips do the digital input and output on
+#	some PowerMacs.
+
+config SND_AOA_TAS
+	tristate "support TAS chips"
+	depends on SND_AOA
+	---help---
+	This option enables support for the tas chips
+	found in a lot of Apple Machines, especially
+	iBooks and PowerBooks without digital.
+
+config SND_AOA_TOONIE
+	tristate "support Toonie chip"
+	depends on SND_AOA
+	---help---
+	This option enables support for the toonie codec
+	found in the Mac Mini. If you have a Mac Mini and
+	want to hear sound, select this option.

--
