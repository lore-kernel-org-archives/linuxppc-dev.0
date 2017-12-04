Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrH4W61x0zDwND
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 07:47:23 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id k134so9051900pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 12:47:23 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct device
Date: Mon,  4 Dec 2017 12:46:34 -0800
Message-Id: <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct device is defined in system level header files any way.
As long as fsl_ssi.h is included after those header files, it
should be safe to remove this line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5065105..5cf56d2 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -206,8 +206,6 @@
 #define CCSR_SSI_SACNT_AC97EN		0x00000001
 
 
-struct device;
-
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct fsl_ssi_dbg {
-- 
2.7.4
