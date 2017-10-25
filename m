Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMk2b3H7FzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 08:35:35 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9PLYP6X061484
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 17:35:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k1w5qj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 17:35:32 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 25 Oct 2017 15:35:31 -0600
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
Date: Wed, 25 Oct 2017 16:35:02 -0500
Message-Id: <1508967302-54403-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series contains miscellaneous fixes. All three patches resolve
minor issues.

This series is intended for 4.15 and is bisectable.

Matthew R. Ochs (3):
  cxlflash: Use derived maximum write same length
  cxlflash: Allow cards without WWPN VPD to configure
  cxlflash: Derive pid through accessors

 drivers/scsi/cxlflash/main.c      | 24 +++++++++++++++++-------
 drivers/scsi/cxlflash/main.h      |  3 ++-
 drivers/scsi/cxlflash/sislite.h   |  3 ---
 drivers/scsi/cxlflash/superpipe.c |  6 +++---
 drivers/scsi/cxlflash/vlun.c      |  6 ++++--
 5 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.1.0
