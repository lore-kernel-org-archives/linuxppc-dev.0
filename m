Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN1Sd5p5XzDvQx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 08:09:37 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALL8Rth096184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:09:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4rpc6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:09:34 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 16:09:33 -0500
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Add device-specific VPD timeout
Date: Mon, 21 Nov 2016 15:03:45 -0600
Message-Id: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This small patch series introduces support for a driver to increase the
VPD wait timeout for devices with slower interfaces.

The series is based on v4.9-rc6 and is intended for v4.10.

Matthew R. Ochs (2):
  PCI: Add pci_set_vpd_timeout() to set VPD access timeout
  cxl: Set VPD timeout to avoid access failures

 drivers/misc/cxl/pci.c |  7 +++++++
 drivers/pci/access.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h      |  2 ++
 include/linux/pci.h    |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.1.0
