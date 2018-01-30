Return-Path: <larry.finger@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zW7sq0sBMzF0Tl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 01:23:58 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id a7so7203973otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 06:23:58 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] macintosh: Add module license to ans-lcd
Date: Tue, 30 Jan 2018 08:23:51 -0600
Message-Id: <20180130142351.23511-1-Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kernel 4.15, the modprobe step on my PowerBook G4 started complaining that
there was no module license for ans-lcd.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - fixed typo in commit message
---
 drivers/macintosh/ans-lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index 1de81d922d8a..c8e078b911c7 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -201,3 +201,4 @@ anslcd_exit(void)
 
 module_init(anslcd_init);
 module_exit(anslcd_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.16.1
