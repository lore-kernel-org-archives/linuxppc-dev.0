Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97E651A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 12:14:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: geoff@infradead.org
Subject: [PATCH] powerpc/ps3: Remove unused os_area_db_id_video_mode
Date: Fri, 25 Sep 2015 12:14:48 +1000
Message-Id: <1443147288-26392-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This struct is unused, which is now a build error with gcc 6:

  error: 'os_area_db_id_video_mode' defined but not used

There doesn't seem to be any good reason to keep it around so remove it,
it's in the history if anyone needs it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/ps3/os-area.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index 09787139834d..3db53e8aff92 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -194,11 +194,6 @@ static const struct os_area_db_id os_area_db_id_rtc_diff = {
 	.key = OS_AREA_DB_KEY_RTC_DIFF
 };
 
-static const struct os_area_db_id os_area_db_id_video_mode = {
-	.owner = OS_AREA_DB_OWNER_LINUX,
-	.key = OS_AREA_DB_KEY_VIDEO_MODE
-};
-
 #define SECONDS_FROM_1970_TO_2000 946684800LL
 
 /**
-- 
2.1.4
