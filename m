Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 719972C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 17:58:14 +1100 (EST)
Received: by mail-ie0-f172.google.com with SMTP id qd12so25930472ieb.31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 22:58:11 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] optimize for powerpc _PAGE_NUMA
Date: Wed,  4 Dec 2013 14:59:05 +0800
Message-Id: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I saw Aneesh had implemented Numa faults on ppc64. Most of them have been reviewed-by.
So I just diff mine and his to form some trivial modification.

Based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"

Liu Ping Fan (3):
  powerpc: mm: make _PAGE_NUMA take effect
  mm: export numa_migrate_prep()
  powerpc: mm: optimize for the correctly placed page

 arch/powerpc/mm/hash_utils_64.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm.h              |  2 ++
 2 files changed, 34 insertions(+)

-- 
1.8.1.4
