Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E9CF1A088D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:52:08 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 17:52:06 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CFBFF6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 17:40:13 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBAMq4IS34144292
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 22:52:04 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBAMn842020379
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 17:49:11 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH 0/6] cxlflash: Miscellaneous fixes and updates
Date: Thu, 10 Dec 2015 16:51:07 -0600
Message-Id: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains miscellaneous fixes and adds support for
a future IBM CXL adapter. This series is intended for 4.5 and is
bisectable.

Manoj Kumar (4):
  cxlflash: Fix to escalate LINK_RESET also on port 1
  cxlflash: Fix to resolve cmd leak after host reset
  cxlflash: Resolve oops in wait_port_offline
  cxlflash: Enable device id for future IBM CXL adapter

Matthew R. Ochs (1):
  cxlflash: Fix to avoid virtual LUN failover failure

Uma Krishnan (1):
  cxlflash: Updated date of the driver

 drivers/scsi/cxlflash/common.h     |  2 ++
 drivers/scsi/cxlflash/main.c       | 51 +++++++++++++++++++++++++++++++++-----
 drivers/scsi/cxlflash/main.h       |  6 ++---
 drivers/scsi/cxlflash/vlun.c       |  2 ++
 include/uapi/scsi/cxlflash_ioctl.h | 10 ++++++++
 5 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.1.0
