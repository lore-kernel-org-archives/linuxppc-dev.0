Return-Path: <jj@chaosbits.net>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by ozlabs.org (Postfix) with ESMTP id CF9A2B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 09:07:19 +1100 (EST)
Date: Mon, 22 Nov 2010 22:54:03 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: alsa-devel@alsa-project.org
Subject: [PATCH] MPC5200: Eliminate duplicate include of of_device.h
Message-ID: <alpine.LNX.2.00.1011222246250.6285@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Eliminate duplicate  #include <linux/of_device.h>  from 
sound/soc/fsl/mpc5200_dma.c

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 mpc5200_dma.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index dce6b55..f92dca0 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 
 #include <sound/soc.h>



-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
