Return-Path: <agordeev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4021714008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:12:35 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Phase out pci_enable_msi_block()
Date: Mon, 14 Apr 2014 09:14:05 +0200
Message-Id: <cover.1397458024.git.agordeev@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Frank Haverkamp <haver@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This series is against 3.15-rc1.

This update obsoletes pci_enable_msi_block() function in
favor of pci_enable_msi_range() and pci_enable_msi_exact().


Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org


Alexander Gordeev (2):
  GenWQE: Use pci_enable_msi_exact() instead of pci_enable_msi_block()
  PCI/MSI: Phase out pci_enable_msi_block()

 drivers/misc/genwqe/card_utils.c |    2 +-
 drivers/pci/msi.c                |   79 ++++++++++++++++----------------------
 include/linux/pci.h              |    5 +--
 3 files changed, 35 insertions(+), 51 deletions(-)

-- 
1.7.7.6
