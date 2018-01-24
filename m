Return-Path: <gustavo@embeddedor.com>
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com
 [192.185.145.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR7rW37S3zDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 13:08:59 +1100 (AEDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway32.websitewelcome.com (Postfix) with ESMTP id 5205D4EE00
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 19:48:47 -0600 (CST)
Date: Tue, 23 Jan 2018 19:48:46 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] macintosh/ams-input: Use true and false for boolean values
Message-ID: <20180124014846.GA27664@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/macintosh/ams/ams-input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/ams/ams-input.c b/drivers/macintosh/ams/ams-input.c
index 2edae7d..fe248f6 100644
--- a/drivers/macintosh/ams/ams-input.c
+++ b/drivers/macintosh/ams/ams-input.c
@@ -91,7 +91,7 @@ static int ams_input_enable(void)
 		return error;
 	}
 
-	joystick = 1;
+	joystick = true;
 
 	return 0;
 }
@@ -104,7 +104,7 @@ static void ams_input_disable(void)
 		ams_info.idev = NULL;
 	}
 
-	joystick = 0;
+	joystick = false;
 }
 
 static ssize_t ams_input_show_joystick(struct device *dev,
-- 
2.7.4
