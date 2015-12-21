Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1DB91A06AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 17:40:24 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FEE3140328
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:40:24 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 21 Dec 2015 16:40:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9CB782BB003F
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:40:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBL6dok822741042
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:40:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBL6djDX028946
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:39:45 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tBL6djE5028120
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:39:45 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id 28C2AA0114
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 17:38:51 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix style of self-test config prompts
Date: Mon, 21 Dec 2015 17:38:41 +1100
Message-Id: <1450679921-23260-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few of the config prompts for powerpc self-tests have periods at the
end, which is inconsistent with the rest of the prompts. Remove the
periods.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 3a510f4..77e2cef 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -64,17 +64,17 @@ config PPC_EMULATED_STATS
 	  emulated.
 
 config CODE_PATCHING_SELFTEST
-	bool "Run self-tests of the code-patching code."
+	bool "Run self-tests of the code-patching code"
 	depends on DEBUG_KERNEL
 	default n
 
 config FTR_FIXUP_SELFTEST
-	bool "Run self-tests of the feature-fixup code."
+	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
 	default n
 
 config MSI_BITMAP_SELFTEST
-	bool "Run self-tests of the MSI bitmap code."
+	bool "Run self-tests of the MSI bitmap code"
 	depends on DEBUG_KERNEL
 	default n
 
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
