Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60D9EB74CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 17:42:10 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id BEEB4DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 17:42:09 +1000 (EST)
Received: by mail-px0-f182.google.com with SMTP id 12so2974207pxi.17
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 00:42:09 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] sound/soc: remove BROKEN from Efika and pcm030 fabric
	drivers
To: jonsmirl@gmail.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@sirena.org.uk, timur@freescale.com
Date: Sun, 28 Jun 2009 01:42:06 -0600
Message-ID: <20090628074158.26905.36950.stgit@localhost.localdomain>
In-Reply-To: <20090628074109.26905.9927.stgit@localhost.localdomain>
References: <20090628074109.26905.9927.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The needed spin_event_timeout() macro is now merged in from the
powerpc tree, so these drivers are no longer broken.  This reverts
commit 0c0e09e21a9e7bc6ca54e06ef3d497255ca26383 (ASoC: Mark MPC5200
AC97 as BROKEN until PowerPC merge issues are resolved)

Tested against 2.6.31-rc1.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5661876..8cb65cc 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -41,7 +41,7 @@ config SND_SOC_MPC5200_AC97
 
 config SND_MPC52xx_SOC_PCM030
 	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
-	depends on PPC_MPC5200_SIMPLE && BROKEN
+	depends on PPC_MPC5200_SIMPLE
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_WM9712
 	help
@@ -50,7 +50,7 @@ config SND_MPC52xx_SOC_PCM030
 
 config SND_MPC52xx_SOC_EFIKA
 	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
-	depends on PPC_EFIKA && BROKEN
+	depends on PPC_EFIKA
 	select SND_SOC_MPC5200_AC97
 	select SND_SOC_STAC9766
 	help
