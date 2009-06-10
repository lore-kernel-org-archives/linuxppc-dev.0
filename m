Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ECF41B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:12 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/33] ps3av: Set 16:9 aspect ratio for 720p video modes
Date: Wed, 10 Jun 2009 16:38:36 +0200
Message-Id: <1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org,
	"sebastian.blanes@gmail.com" <sebastian.blanes@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: sebastian.blanes@gmail.com <sebastian.blanes@gmail.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/ps3/ps3av.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 235e87f..4e4611e 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -80,12 +80,12 @@ static const struct avset_video_mode {
 	{     0, }, /* auto */
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480I,       A_N,  720,  480},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480P,       A_N,  720,  480},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_N, 1280,  720},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_W, 1280,  720},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_60HZ, A_W, 1920, 1080},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_60HZ, A_W, 1920, 1080},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576I,       A_N,  720,  576},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576P,       A_N,  720,  576},
-	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_N, 1280,  720},
+	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_W, 1280,  720},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_50HZ, A_W, 1920, 1080},
 	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_50HZ, A_W, 1920, 1080},
 	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WXGA,       A_W, 1280,  768},
-- 
1.6.2.4
