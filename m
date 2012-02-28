Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5B78B6FFC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 06:49:53 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: [PATCH trivial next 0/9] treewide: Use vsprintf extention %pf
Date: Tue, 28 Feb 2012 10:49:29 -0800
Message-Id: <cover.1330454853.git.joe@perches.com>
Cc: devel@driverdev.osuosl.org, microblaze-uclinux@itee.uq.edu.au,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emit the actual function name when possible

Joe Perches (9):
  sparc: Use vsprintf extention %pf with builtin_return_address
  alpha: Use vsprintf extention %pf with builtin_return_address
  arm: Use vsprintf extention %pf with builtin_return_address
  microblaze: Use vsprintf extention %pf with builtin_return_address
  powerpc: Use vsprintf extention %pf with builtin_return_address
  parisc: Use vsprintf extention %pf with builtin_return_address
  scsi: Use vsprintf extention %pf with builtin_return_address
  staging: ramster: Use vsprintf extention %pf with builtin_return_address
  gadget: Use vsprintf extention %pf with builtin_return_address

 arch/alpha/kernel/pci_iommu.c               |   20 ++++++++++----------
 arch/arm/nwfpe/fpmodule.c                   |    2 +-
 arch/microblaze/mm/pgtable.c                |    2 +-
 arch/powerpc/mm/pgtable_32.c                |    2 +-
 arch/sparc/kernel/ds.c                      |    2 +-
 arch/sparc/mm/srmmu.c                       |    2 +-
 drivers/parisc/superio.c                    |    2 +-
 drivers/scsi/esp_scsi.c                     |    2 +-
 drivers/staging/ramster/cluster/heartbeat.c |    4 ++--
 drivers/usb/gadget/u_serial.c               |    2 +-
 10 files changed, 20 insertions(+), 20 deletions(-)

-- 
1.7.8.111.gad25c.dirty
