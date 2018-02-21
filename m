Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmYnY3WcgzDrPf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:36:46 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1LAZO86133183
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:44 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g96mt19t5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 05:36:40 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 10:36:37 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC PATCH v0 0/2] ibm,dynamic-memory-v2 fix
Date: Wed, 21 Feb 2018 16:06:25 +0530
Message-Id: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch 1 fixes a bug that results in unexpected flag bit in
ibm,dynamic-memory-v2 DT property and wrong number of entries
getting created in the same property during hotplug.

Patch 2 can be optionally considered. It renames DRMEM_LMB_RESERVED
to DRMEM_LMB_ISOLATED. May be it could be renamed to even more
appropriate name.

Bharata B Rao (2):
  powerpc,drmem: Fix unexpected flag value in ibm,dynamic-memory-v2
  powerpc,drmem: Rename DRMEM_LMB_RESERVED to DRMEM_LMB_ISOLATED

 arch/powerpc/include/asm/drmem.h                | 14 ++++-----
 arch/powerpc/mm/drmem.c                         |  8 ++---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 40 ++++++++++++-------------
 3 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.7.4
