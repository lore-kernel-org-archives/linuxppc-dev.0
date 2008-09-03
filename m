Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 68518DE2D5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 06:02:37 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] sbc8560: fix compile warning on CPM pin array
Date: Wed,  3 Sep 2008 16:02:25 -0400
Message-Id: <1220472145-1663-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is just a parallel of a5dc66e2ab2e2cf641346b056a69a67cfcf9458c
applied to the sbc8560 board.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/sbc8560.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index c34b33d..4d1ea1a 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -156,7 +156,7 @@ static void __init init_ioports(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sbc8560_pins); i++) {
-		struct cpm_pin *pin = &sbc8560_pins[i];
+		const struct cpm_pin *pin = &sbc8560_pins[i];
 		cpm2_set_pin(pin->port, pin->pin, pin->flags);
 	}
 
-- 
1.6.0
