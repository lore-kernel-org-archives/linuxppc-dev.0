Return-Path: <fabf@skynet.be>
Received: from mailrelay106.isp.belgacom.be (mailrelay106.isp.belgacom.be
 [195.238.20.133])
 by lists.ozlabs.org (Postfix) with ESMTP id 7D5781A04E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 03:49:24 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7 linux-next] ALSA: aoa: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:56 +0100
Message-Id: <1426697344-4884-2-git-send-email-fabf@skynet.be>
In-Reply-To: <1426697344-4884-1-git-send-email-fabf@skynet.be>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/aoa/soundbus/i2sbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index b9737fa..1cbf210 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -31,7 +31,7 @@ module_param(force, int, 0444);
 MODULE_PARM_DESC(force, "Force loading i2sbus even when"
 			" no layout-id property is present");
 
-static struct of_device_id i2sbus_match[] = {
+static const struct of_device_id i2sbus_match[] = {
 	{ .name = "i2s" },
 	{ }
 };
-- 
1.9.1
