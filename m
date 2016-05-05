Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0vDF3PLmzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 22:22:05 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 5 May 2016 17:41:51 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1C06B394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 17:41:49 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u45CBm6C19726462
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u45CBj7j022637
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 17:41:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au, mikey@neuling.org,
 oohall@gmail.com
Subject: [PATCH 0/2] Enable ZONE_DEVICE on POWER
Date: Thu,  5 May 2016 17:41:42 +0530
Message-Id: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables base ZONE_DEVICE support on POWER. This series depends on
the following patches posted by Oliver.

https://patchwork.ozlabs.org/patch/618867/
https://patchwork.ozlabs.org/patch/618868/

Anshuman Khandual (2):
  powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE memory
  powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64 platforms

 arch/powerpc/mm/init_64.c | 4 +++-
 mm/Kconfig                | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.3
