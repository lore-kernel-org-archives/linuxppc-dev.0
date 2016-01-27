Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A6251A0072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 11:30:55 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54DCB140BD1
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:30:55 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Jan 2016 10:30:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 269AD3578053
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:30:51 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0R0UTTq42795094
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:30:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0R0UFF3018410
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:30:15 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0R0UFKM017587
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:30:15 +1100
Received: from ajd.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 by ozlabs.au.ibm.com (Postfix) with ESMTP id E1766A0130
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 11:29:50 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: fix typo in usage message
Date: Wed, 27 Jan 2016 11:29:44 +1100
Message-Id: <1453854584-1049-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 07a8508..d5c8a15 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -233,7 +233,7 @@ Commands:\n\
 "  S	print special registers\n\
   t	print backtrace\n\
   x	exit monitor and recover\n\
-  X	exit monitor and dont recover\n"
+  X	exit monitor and don't recover\n"
 #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
 "  u	dump segment table or SLB\n"
 #elif defined(CONFIG_PPC_STD_MMU_32)
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
