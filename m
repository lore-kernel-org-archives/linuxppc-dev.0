Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D1951A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:58:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 10:58:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 570452BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:58:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7I0wTig38600708
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:58:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7I0w60E024590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 10:58:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Export include/uapi/asm/eeh.h
Date: Tue, 18 Aug 2015 10:57:40 +1000
Message-Id: <1439859460-7497-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds include/uapi/asm/eeh.h to kbuild so that the header
file will be exported automatically with below command. The
header file was added by commit ed3e81f ("powerpc/eeh: Move PE
state constants around")

   make INSTALL_HDR_PATH=/tmp/headers \
        SRCARCH=powerpc headers_install

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index f44a0278..dab3717 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -6,6 +6,7 @@ header-y += bitsperlong.h
 header-y += bootx.h
 header-y += byteorder.h
 header-y += cputable.h
+header-y += eeh.h
 header-y += elf.h
 header-y += epapr_hcalls.h
 header-y += errno.h
-- 
2.1.0
