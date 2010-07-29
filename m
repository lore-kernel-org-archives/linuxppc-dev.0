Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7DB4B6EFF
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 10:28:48 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 0/2 v1.04] Add support for DWC OTG driver.
Date: Wed, 28 Jul 2010 17:28:41 -0700
Message-Id: <12803633233020-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 1/2 v1.04]
1. License information is under clarification.
2. Difference in v1.04 patch.
	Added drivers/usb/dwc_otg/dwc_otg_param.c to [PATCH 1/2 v1.03] patch.
	Coding style:
		Added space line after declaration.
	drivers/usb/dwc_otg/Kconfig:
		Set dwc_otg driver to host mode in [PATCH 1/2 v1.04].
		DWC_LIMITED_XFER_SIZE is selectable.
