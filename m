Return-Path: <mike@mikebwilliams.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4F361007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jul 2011 02:10:20 +1000 (EST)
Received: by qwf7 with SMTP id 7so557081qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Jul 2011 09:10:16 -0700 (PDT)
From: Mike Williams <mike@mikebwilliams.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc,ppc4xx_edac: Add comma to fix build error
Date: Thu,  7 Jul 2011 12:09:58 -0400
Message-Id: <1310054998-27002-1-git-send-email-mike@mikebwilliams.com>
Cc: Mike Williams <mike@mikebwilliams.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4018294b53d1dae026880e45f174c1cc63b5d435 broke the ppc4xx_edac driver at
line 210 where the struct member is missing a comma.

Signed-off-by: Mike Williams <mike@mikebwilliams.com>
---
 drivers/edac/ppc4xx_edac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index b9f0c20..446b5c0 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -206,7 +206,7 @@ static struct of_platform_driver ppc4xx_edac_driver = {
 	.remove			= ppc4xx_edac_remove,
 	.driver = {
 		.owner = THIS_MODULE,
-		.name = PPC4XX_EDAC_MODULE_NAME
+		.name = PPC4XX_EDAC_MODULE_NAME,
 		.of_match_table = ppc4xx_edac_match,
 	},
 };
-- 
1.7.3.4
