Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk500nrHzDqNk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:04:52 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id t6so62996lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:04:51 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, geoff@infradead.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0218/1529] Fix typo
Date: Sat, 21 May 2016 14:04:42 +0200
Message-Id: <20160521120442.11309-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/include/asm/ps3av.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3av.h b/arch/powerpc/include/asm/ps3av.h
index 0427b0b..5176613 100644
--- a/arch/powerpc/include/asm/ps3av.h
+++ b/arch/powerpc/include/asm/ps3av.h
@@ -104,7 +104,7 @@
 #define PS3AV_CMD_AV_INPUTLEN_16			0x02
 #define PS3AV_CMD_AV_INPUTLEN_20			0x0a
 #define PS3AV_CMD_AV_INPUTLEN_24			0x0b
-/* alayout */
+/* av_layout */
 #define PS3AV_CMD_AV_LAYOUT_32				(1 << 0)
 #define PS3AV_CMD_AV_LAYOUT_44				(1 << 1)
 #define PS3AV_CMD_AV_LAYOUT_48				(1 << 2)
@@ -688,7 +688,7 @@ extern u8 ps3av_mode_cs_info[];
 #define PS3AV_STATUS_INVALID_COMMAND		0x0003	/* obsolete invalid CID */
 #define PS3AV_STATUS_INVALID_PORT		0x0004	/* invalid port number */
 #define PS3AV_STATUS_INVALID_VID		0x0005	/* invalid video format */
-#define PS3AV_STATUS_INVALID_COLOR_SPACE	0x0006	/* invalid video colose space */
+#define PS3AV_STATUS_INVALID_COLOR_SPACE	0x0006	/* invalid video close space */
 #define PS3AV_STATUS_INVALID_FS			0x0007	/* invalid audio sampling freq */
 #define PS3AV_STATUS_INVALID_AUDIO_CH		0x0008	/* invalid audio channel number */
 #define PS3AV_STATUS_UNSUPPORTED_VERSION	0x0009	/* version mismatch  */
-- 
2.8.2.534.g1f66975
