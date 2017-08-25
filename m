Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xfFsC6yqBzDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Aug 2017 08:17:35 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7PMDk5F154402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 18:17:31 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cjq360t74-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 18:17:31 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 25 Aug 2017 18:17:30 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 0/3] cxlflash: Miscellaneous fixes
Date: Fri, 25 Aug 2017 17:17:20 -0500
Message-Id: <1503699440-61464-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series contains miscellaneous fixes. The first two address
issues that were identified by smatch and the last patch fixes a regression
introduced by Commit 565180723294 ("scsi: cxlflash: SISlite updates to
support 4 ports").

This series is intended for 4.14 and is bisectable.

Matthew R. Ochs (2):
  cxlflash: Remove unnecessary existence check
  cxlflash: Avoid double mutex unlock

Uma Krishnan (1):
  cxlflash: Fix vlun resize failure in the shrink path

 drivers/scsi/cxlflash/main.c      |  3 +--
 drivers/scsi/cxlflash/superpipe.c | 13 ++++++++++---
 drivers/scsi/cxlflash/vlun.c      |  6 +-----
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.1.0
