Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FF7F1A048D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:48:32 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 502A0140283
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:48:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 15 May 2015 15:48:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D5D512BB0040
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:48:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F5mJYP25755878
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:48:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F5ltBE002054
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:47:55 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t4F5lt4r001346
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:47:55 +1000
Received: from cyril.ozlabs.ibm.com (unknown [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B412CA0188
 for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2015 15:47:30 +1000 (AEST)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/configs: merge pseries_defconfig and
 pseries_le_defconfig
Date: Fri, 15 May 2015 15:47:09 +1000
Message-Id: <1431668830-22734-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two configs should be identical with the exception of big or little
endian

The big endian version has XMON_DEFAULT turned on while the little endian has
XMON_DEFAULT not set. Enable XMON_DEFAULT for little endian.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/configs/pseries_le_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/pseries_le_defconfig b/arch/powerpc/configs/pseries_le_defconfig
index 09bc96e..2497c7d 100644
--- a/arch/powerpc/configs/pseries_le_defconfig
+++ b/arch/powerpc/configs/pseries_le_defconfig
@@ -298,6 +298,7 @@ CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
-- 
1.9.1
