Return-Path: <B16395@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73E4A2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 22:36:23 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <stuart.yoder@freescale.com>, <scottwood@freescale.com>,
 <alex.williamson@redhat.com>, <r65777@freescale.com>
Subject: [PATCH 0/3 v2] iommu/fsl: PAMU driver fixes.
Date: Wed, 16 Oct 2013 16:52:59 +0530
Message-ID: <1381922582-28724-1-git-send-email-Varun.Sethi@freescale.com>
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

The first patch fixes a build failure, when we try to build for a Freescale
platform without PCI support.

The second patch enables a default DMA window for the device, once it's
detached from a domain. In case of vfio, once device is detached from a
guest it can be again used by the host.

The last patch adds the maintainer entry for the Freescale PAMU driver.

Varun Sethi (3):
  iommu/fsl: Factor out PCI specific code.
  iommu/fsl: Enable default DMA window for PCIe devices once detached
  Add maintainers entry for the Freescale PAMU driver.

 MAINTAINERS                     |    7 ++
 drivers/iommu/fsl_pamu.c        |   43 ++++++++++---
 drivers/iommu/fsl_pamu.h        |    1 +
 drivers/iommu/fsl_pamu_domain.c |  134 +++++++++++++++++++++++++--------------
 4 files changed, 128 insertions(+), 57 deletions(-)

-- 
1.7.9.5
