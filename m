Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 76F6DDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 09:51:33 +1100 (EST)
Date: Mon, 12 Nov 2007 16:51:16 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] remove prod_processor()
Message-ID: <20071112225116.GG26313@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

prod_processor() is unused, and that's a good thing, since it does not
supply the required proc id parameter to H_PROD.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index d003c80..d8680b5 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -8,11 +8,6 @@ static inline long poll_pending(void)
 	return plpar_hcall_norets(H_POLL_PENDING);
 }
 
-static inline long prod_processor(void)
-{
-	return plpar_hcall_norets(H_PROD);
-}
-
 static inline long cede_processor(void)
 {
 	return plpar_hcall_norets(H_CEDE);
-- 
1.5.3.4.206.g58ba4
