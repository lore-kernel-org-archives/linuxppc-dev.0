Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C28D4B7111
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 12:06:37 +1100 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH V5 0/9] Add Synopsys DesignWare HS USB OTG driver
Date: Wed, 20 Oct 2010 18:06:34 -0700
Message-Id: <12876231942694-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series add Synopsys DesignWare HS USB OTG driver support.

"PATCH V5" has a new license header from Synopsys and APM 
Previous versions:
  1. Addressed comment from Wolfgang Denk to sync with
     git://git.denx.de/linux-2.6-denx.git.
  2. Added bug fixes and features from Stefan Roese and Chuck Meade.
  3. Removed dts file from this pathch per Sergei Shtylyov suggestion.
     We'll submit a separate patch to PowerPC tree.
  4. Modified driver to use generic USB OTG enumeration state.
  5. Move Makefiles to the last patch per David Daney suggestion.

Fushen Chen (9):
  Add Synopsys DesignWare HS USB OTG Control and Status Register (CSR).
  Add Synopsys DesignWare HS USB OTG driver framework.
  Add Synopsys DesignWare HS USB OTG Core Interface Layer (CIL).
  Add Synopsys DesignWare HS USB OTG HCD function.
  Add Synopsys DesignWare HS USB OTG HCD interrupt function.
  Add Synopsys DesignWare HS USB OTG HCD queue function.
  Add Synopsys DesignWare HS USB OTG PCD function.
  Add Synopsys DesignWare HS USB OTG PCD interrupt function.
  Add Synopsys DesignWare HS USB OTG driver kernel configuration and
    Makefile.

 drivers/Makefile                        |    1 +
 drivers/usb/Kconfig                     |    2 +
 drivers/usb/dwc_otg/Kconfig             |   99 +
 drivers/usb/dwc_otg/Makefile            |   19 +
 drivers/usb/dwc_otg/dwc_otg_apmppc.c    |  394 ++++
 drivers/usb/dwc_otg/dwc_otg_cil.c       |  892 +++++++++
 drivers/usb/dwc_otg/dwc_otg_cil.h       | 1181 +++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil_intr.c  |  618 ++++++
 drivers/usb/dwc_otg/dwc_otg_driver.h    |   78 +
 drivers/usb/dwc_otg/dwc_otg_hcd.c       | 2400 +++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd.h       |  413 ++++
 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c  | 1465 ++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c |  697 +++++++
 drivers/usb/dwc_otg/dwc_otg_param.c     |  730 +++++++
 drivers/usb/dwc_otg/dwc_otg_pcd.c       | 1733 ++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_pcd.h       |  137 ++
 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c  | 2262 +++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_regs.h      | 3269 +++++++++++++++++++++++++++++++
 18 files changed, 16390 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc_otg/Kconfig
 create mode 100644 drivers/usb/dwc_otg/Makefile
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_apmppc.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_driver.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_param.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_regs.h

-- 
1.7.3
