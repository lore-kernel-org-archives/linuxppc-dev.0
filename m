Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16ED72C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 20:03:57 +1100 (EST)
Received: by mail-ie0-f179.google.com with SMTP id 9so3683404iec.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 01:03:54 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 0/2] vfio powerpc: implemented and enabled
Date: Fri, 23 Nov 2012 20:03:14 +1100
Message-Id: <1353661396-14374-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1353435584.2234.87.camel@bling.home>
References: <1353435584.2234.87.camel@bling.home>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series includes IOMMU implementation and necessary IOMMU groups initialization.

Alexey Kardashevskiy (2):
  vfio powerpc: implemented IOMMU driver for VFIO
  vfio powerpc: enabled on powernv platform

 arch/powerpc/include/asm/iommu.h     |    6 +
 arch/powerpc/kernel/iommu.c          |  141 +++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.c |  135 +++++++++++++++++++
 drivers/iommu/Kconfig                |    8 ++
 drivers/vfio/Kconfig                 |    6 +
 drivers/vfio/Makefile                |    1 +
 drivers/vfio/vfio_iommu_spapr_tce.c  |  247 ++++++++++++++++++++++++++++++++++
 include/linux/vfio.h                 |   20 +++
 8 files changed, 564 insertions(+)
 create mode 100644 drivers/vfio/vfio_iommu_spapr_tce.c

-- 
1.7.10.4
