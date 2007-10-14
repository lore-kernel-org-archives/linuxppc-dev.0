Return-Path: <grant.likely@secretlab.ca>
Date: Sat, 13 Oct 2007 22:13:32 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] XilinxFB: typo bugfix
In-reply-to: <20071014040705.17867.42969.stgit@trillian.cg.shawcable.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: <20071014041332.17867.20597.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071014040705.17867.42969.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6ef99b2..e38d3b7 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -84,7 +84,7 @@ static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
 	.xres = 640,
 	.yres = 480,
 	.xvirt = 1024,
-	.yvirt = 480;
+	.yvirt = 480,
 };
 
 /*
