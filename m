Return-Path: <valentin.ilie@gmail.com>
From: Valentin Ilie <valentin.ilie@gmail.com>
To: geoff@infradead.org
Subject: [PATCH] Drivers: ps3: ps3av.c: fixed checkpatch warnings
Date: Wed, 18 Apr 2012 12:33:31 +0300
Message-Id: <1334741611-3296-1-git-send-email-valentin.ilie@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Valentin Ilie <valentin.ilie@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed some checkpatch warnings. (review)
Last patch didn't compile.

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
---
 drivers/ps3/ps3av.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index a409fa0..636e618 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -338,7 +338,7 @@ int ps3av_do_pkt(u32 cid, u16 send_len, size_t usr_buf_size,
 	mutex_unlock(&ps3av->mutex);
 	return 0;
 
-      err:
+err:
 	mutex_unlock(&ps3av->mutex);
 	printk(KERN_ERR "%s: failed cid:%x res:%d\n", __func__, cid, res);
 	return res;
@@ -477,7 +477,6 @@ int ps3av_set_audio_mode(u32 ch, u32 fs, u32 word_bits, u32 format, u32 source)
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_set_audio_mode);
 
 static int ps3av_set_videomode(void)
@@ -870,21 +869,18 @@ int ps3av_set_video_mode(int id)
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_set_video_mode);
 
 int ps3av_get_auto_mode(void)
 {
 	return ps3av_auto_videomode(&ps3av->av_hw_conf);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_get_auto_mode);
 
 int ps3av_get_mode(void)
 {
 	return ps3av ? ps3av->ps3av_mode : 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_get_mode);
 
 /* get resolution by video_mode */
@@ -902,7 +898,6 @@ int ps3av_video_mode2res(u32 id, u32 *xres, u32 *yres)
 	*yres = video_mode_table[id].y;
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ps3av_video_mode2res);
 
 /* mute */
@@ -911,7 +906,6 @@ int ps3av_video_mute(int mute)
 	return ps3av_set_av_video_mute(mute ? PS3AV_CMD_MUTE_ON
 					    : PS3AV_CMD_MUTE_OFF);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_video_mute);
 
 /* mute analog output only */
@@ -935,7 +929,6 @@ int ps3av_audio_mute(int mute)
 	return ps3av_set_audio_mute(mute ? PS3AV_CMD_MUTE_ON
 					 : PS3AV_CMD_MUTE_OFF);
 }
-
 EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 
 static int __devinit ps3av_probe(struct ps3_system_bus_device *dev)
-- 
1.7.9.5
