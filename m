Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qMkY16t1zF16W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:14:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LF8lsD001681
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j40esgfu5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:10 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 21 May 2018 16:14:08 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] selftests/powerpc: Add test for rfi_flush
Date: Mon, 21 May 2018 20:43:55 +0530
Message-Id: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v2 of:
https://patchwork.ozlabs.org/patch/895765/

Changes:
- Patch 1 is new.
- Patch 2 uses the new macro introduced in the first patch. The output 
  message has also been slightly tweaked to make things clearer.


- Naveen

Naveen N. Rao (2):
  selftests/powerpc: Move UCONTEXT_NIA() into utils.h
  selftests/powerpc: Add test to verify rfi flush across a system call

 tools/testing/selftests/powerpc/Makefile      |   3 +-
 .../testing/selftests/powerpc/include/utils.h |  18 +++
 .../primitives/load_unaligned_zeropad.c       |   8 -
 .../selftests/powerpc/security/Makefile       |   7 +
 .../selftests/powerpc/security/rfi_flush.c    | 132 +++++++++++++++
 tools/testing/selftests/powerpc/utils.c       | 153 ++++++++++++++++++
 6 files changed, 312 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/security/Makefile
 create mode 100644 tools/testing/selftests/powerpc/security/rfi_flush.c

-- 
2.17.0
