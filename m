Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DFADAB70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:25 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 26/33] sound/ps3: Fix checkpatch issues
Date: Wed, 10 Jun 2009 16:39:01 +0200
Message-Id: <1244644748-24211-27-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-21-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-22-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-25-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-26-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	cbe-oss-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/snd_ps3.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index f361c26..d660b0f 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -165,8 +165,7 @@ static const struct snd_pcm_hardware snd_ps3_pcm_hw = {
 	.fifo_size = PS3_AUDIO_FIFO_SIZE
 };
 
-static struct snd_pcm_ops snd_ps3_pcm_spdif_ops =
-{
+static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 	.open = snd_ps3_pcm_open,
 	.close = snd_ps3_pcm_close,
 	.prepare = snd_ps3_pcm_prepare,
@@ -183,7 +182,7 @@ static int snd_ps3_verify_dma_stop(struct snd_ps3_card_info *card,
 	int dma_ch, done, retries, stop_forced = 0;
 	uint32_t status;
 
-	for (dma_ch = 0; dma_ch < 8; dma_ch ++) {
+	for (dma_ch = 0; dma_ch < 8; dma_ch++) {
 		retries = count;
 		do {
 			status = read_reg(PS3_AUDIO_KICK(dma_ch)) &
@@ -259,9 +258,7 @@ static void snd_ps3_kick_dma(struct snd_ps3_card_info *card)
 /*
  * convert virtual addr to ioif bus addr.
  */
-static dma_addr_t v_to_bus(struct snd_ps3_card_info *card,
-			   void * paddr,
-			   int ch)
+static dma_addr_t v_to_bus(struct snd_ps3_card_info *card, void *paddr, int ch)
 {
 	return card->dma_start_bus_addr[ch] +
 		(paddr - card->dma_start_vaddr[ch]);
@@ -321,7 +318,7 @@ static int snd_ps3_program_dma(struct snd_ps3_card_info *card,
 	spin_lock_irqsave(&card->dma_lock, irqsave);
 	for (ch = 0; ch < 2; ch++) {
 		start_vaddr = card->dma_next_transfer_vaddr[0];
-		for (stage = 0; stage < fill_stages; stage ++) {
+		for (stage = 0; stage < fill_stages; stage++) {
 			dma_ch = stage * 2 + ch;
 			if (silent)
 				dma_addr = card->null_buffer_start_dma_addr;
@@ -619,7 +616,7 @@ static int snd_ps3_change_avsetting(struct snd_ps3_card_info *card)
 			  PS3_AUDIO_AO_3WMCTRL_ASOEN(2) |
 			  PS3_AUDIO_AO_3WMCTRL_ASOEN(3)),
 			0);
-	wmb(); 	/* ensure the hardware sees the change */
+	wmb();	/* ensure the hardware sees the change */
 	/* wait for actually stopped */
 	retries = 1000;
 	while ((read_reg(PS3_AUDIO_AO_3WMCTRL) &
@@ -798,20 +795,20 @@ static struct snd_kcontrol_new spdif_ctls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,CON_MASK),
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, CON_MASK),
 		.info = snd_ps3_spdif_mask_info,
 		.get = snd_ps3_spdif_cmask_get,
 	},
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ,
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,PRO_MASK),
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, PRO_MASK),
 		.info = snd_ps3_spdif_mask_info,
 		.get = snd_ps3_spdif_pmask_get,
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
 		.info = snd_ps3_spdif_mask_info,
 		.get = snd_ps3_spdif_default_get,
 		.put = snd_ps3_spdif_default_put,
@@ -1020,11 +1017,12 @@ static int __init snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 	 * its size should be lager than PS3_AUDIO_FIFO_STAGE_SIZE * 2
 	 * PAGE_SIZE is enogh
 	 */
-	if (!(the_card.null_buffer_start_vaddr =
-	      dma_alloc_coherent(&the_card.ps3_dev->core,
-				 PAGE_SIZE,
-				 &the_card.null_buffer_start_dma_addr,
-				 GFP_KERNEL))) {
+	the_card.null_buffer_start_vaddr =
+		dma_alloc_coherent(&the_card.ps3_dev->core,
+				   PAGE_SIZE,
+				   &the_card.null_buffer_start_dma_addr,
+				   GFP_KERNEL);
+	if (!the_card.null_buffer_start_vaddr) {
 		pr_info("%s: nullbuffer alloc failed\n", __func__);
 		goto clean_preallocate;
 	}
@@ -1148,7 +1146,7 @@ static irqreturn_t snd_ps3_interrupt(int irq, void *dev_id)
 				SND_PS3_DMA_FILLTYPE_SILENT_FIRSTFILL :
 				SND_PS3_DMA_FILLTYPE_SILENT_RUNNING);
 			snd_ps3_kick_dma(card);
-			card->silent --;
+			card->silent--;
 		} else {
 			snd_ps3_program_dma(card,
 				(underflow_occured) ?
-- 
1.6.2.4
