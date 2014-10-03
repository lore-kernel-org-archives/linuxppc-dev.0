Return-Path: <tomeu.vizoso@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4596C1A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 01:54:34 +1000 (EST)
Received: by mail-wg0-f52.google.com with SMTP id a1so1852380wgh.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Oct 2014 08:54:31 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: 
Subject: [PATCH] ASoC: fsl_spdif: Remove unused includes of linux/clk-private.h
Date: Fri,  3 Oct 2014 17:54:13 +0200
Message-Id: <1412351653-29592-1-git-send-email-tomeu.vizoso@collabora.com>
Cc: alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 sound/soc/fsl/fsl_spdif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 70acfe4..5bda323 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -15,7 +15,6 @@
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
-#include <linux/clk-private.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-- 
1.9.3
