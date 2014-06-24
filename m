Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EDDD1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 00:32:16 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alex.williamson@redhat.com>
Subject: [PATCH 0/3] iommu/fsl: Fixes for the PAMU driver. 
Date: Tue, 24 Jun 2014 19:27:14 +0530
Message-ID: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains fixes for the PAMU driver. 
The patches are based on 3.16-rc1.

Varun Sethi (3):
  Fix PAMU window size check. 
  Fix the device domain attach condition.
  Fix the error condition during iommu group creation.

 drivers/iommu/fsl_pamu.c        |    8 ++++----
 drivers/iommu/fsl_pamu_domain.c |   19 +++++++++----------
 2 files changed, 13 insertions(+), 14 deletions(-)

-- 
1.7.9.5
