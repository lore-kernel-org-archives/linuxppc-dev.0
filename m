Return-Path: <panweiping3@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50EC3B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 20:14:54 +1000 (EST)
Received: by wwi36 with SMTP id 36so5648297wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 03:14:51 -0700 (PDT)
From: =?UTF-8?q?Weiping=20Pan=28=E6=BD=98=E5=8D=AB=E5=B9=B3=29?=
	<panweiping3@gmail.com>
To: 
Subject: [PATCH 3/4] usb:fix a typo
Date: Mon, 11 Apr 2011 18:16:15 +0800
Message-Id: <1302516975-9575-1-git-send-email-panweiping3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	"=?UTF-8?q?Weiping=20Pan ?= \(=E6=BD=98=E5=8D=AB=E5=B9=B3\)"
	<panweiping3@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE USB PER..." <linux-usb@vger.kernel.org>,
	"open list:FREESCALE USB PER..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

replace tranmitted with transmitted.

Signed-off-by: Weiping Pan(潘卫平) <panweiping3@gmail.com>
---
 drivers/usb/gadget/fsl_qe_udc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.h b/drivers/usb/gadget/fsl_qe_udc.h
index e35e24f..1da5fb0 100644
--- a/drivers/usb/gadget/fsl_qe_udc.h
+++ b/drivers/usb/gadget/fsl_qe_udc.h
@@ -207,7 +207,7 @@ struct qe_frame{
 
 /* Frame status field */
 /* Receive side */
-#define FRAME_OK               0x00000000 /* Frame tranmitted or received OK */
+#define FRAME_OK               0x00000000 /* Frame transmitted or received OK */
 #define FRAME_ERROR            0x80000000 /* Error occurred on frame */
 #define START_FRAME_LOST       0x40000000 /* START_FRAME_LOST */
 #define END_FRAME_LOST         0x20000000 /* END_FRAME_LOST */
-- 
1.7.4
