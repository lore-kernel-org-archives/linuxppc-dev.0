Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75CA6B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Jan 2011 09:57:25 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V8 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
Date: Wed, 19 Jan 2011 14:57:16 -0800
Message-Id: <1295477836-14589-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

v8:
 1. Add set_wedge to usb_ep_ops.

v7:
 1. Fix sparse tool warnings.
 2. Fix checkpatch errors and warnings.
 3. Rename USB_OTG config variable to USB_DWC_CONFIG

Tirumala Marri (10):
  USB/ppc4xx: Add Synopsys DWC OTG Register definitions
  USB/ppc4xx: Add Synopsys DWC OTG driver framework
  USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer
  USB/ppc4xx: Add Synopsys DWC OTG HCD function
  USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
  USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
  USB/ppc4xx: Add Synopsys DWC OTG PCD function
  USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
  USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
  USB ppc4xx: Add Synopsys DWC OTG driver kernel configuration and
    Makefile

 drivers/Makefile                        |    2 +
 drivers/usb/Kconfig                     |    3 +-
 drivers/usb/dwc_otg/Kconfig             |   96 ++
 drivers/usb/dwc_otg/Makefile            |   19 +
 drivers/usb/dwc_otg/dwc_otg_apmppc.c    |  414 ++++++
 drivers/usb/dwc_otg/dwc_otg_cil.c       |  972 ++++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil.h       | 1220 +++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil_intr.c  |  616 ++++++++
 drivers/usb/dwc_otg/dwc_otg_driver.h    |   76 +
 drivers/usb/dwc_otg/dwc_otg_hcd.c       | 2466 +++++++++++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd.h       |  416 ++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c  | 1477 ++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c |  696 +++++++++
 drivers/usb/dwc_otg/dwc_otg_param.c     |  180 +++
 drivers/usb/dwc_otg/dwc_otg_pcd.c       | 1766 ++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_pcd.h       |  139 ++
 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c  | 2311 +++++++++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_regs.h      | 1325 +++++++++++++++++
 drivers/usb/gadget/Kconfig              |   22 +
 drivers/usb/gadget/gadget_chips.h       |    9 +
 20 files changed, 14224 insertions(+), 1 deletions(-)
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
