Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF206218FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KoSX8ESo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF206218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3zK5B9fzDq7g
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:25:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="KoSX8ESo"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3xW4nSHzDq9Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:23:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jlcS8uWk+Yp7M7Is6NXHNjZVzCGZqfqZLTxx3PEchpU=; b=KoSX8ESoqmD1eio80lW5+aqiRx
 iwGpshWrI4GEg8eUUd6ADgubx2guBxFy8VEqUdfSTocl8/MBSL8oJ50rnpaDrXYJRH+LXRNg/rihu
 RvSYRdnLSxrklZOklXGLuKovfdFZ2BmSKDQcEg5KtBz2OwN+Gs4YZOVEtjraoP/Wy5vVDFZlxae/B
 hjbHCocVCDFAUskUz6Bsv380GJguhnS0nHOEJFuYBaN90swQPRTlpg3fKeFsDdgWskOQH36s8EK2+
 Ua6DSFVlXeG8SABBeJbCO0+iNEgLzm5amemRTpEFOBqj1ERuB98KOwJmrvS/lM+6R0oIWhxndUWd+
 DnbTXEfQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJJkE-0002EN-8d; Wed, 24 Apr 2019 15:23:34 +0000
Date: Wed, 24 Apr 2019 12:23:27 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 27/63] Documentation: PCI: convert PCIEBUS-HOWTO.txt
 to reST
Message-ID: <20190424122327.1ff0c975@coco.lan>
In-Reply-To: <20190423162932.21428-28-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-28-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:28:56 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 140 ++++++++++--------
>  Documentation/PCI/index.rst                   |   1 +
>  2 files changed, 82 insertions(+), 59 deletions(-)
>  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (70%)

Names in lowercase after rename, please.

For the changes itself at the txt file:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> diff --git a/Documentation/PCI/PCIEBUS-HOWTO.txt b/Documentation/PCI/PCIEBUS-HOWTO.rst
> similarity index 70%
> rename from Documentation/PCI/PCIEBUS-HOWTO.txt
> rename to Documentation/PCI/PCIEBUS-HOWTO.rst
> index 15f0bb3b5045..f882ff62c51f 100644
> --- a/Documentation/PCI/PCIEBUS-HOWTO.txt
> +++ b/Documentation/PCI/PCIEBUS-HOWTO.rst
> @@ -1,16 +1,23 @@
> -		The PCI Express Port Bus Driver Guide HOWTO
> -	Tom L Nguyen tom.l.nguyen@intel.com
> -			11/03/2004
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>  
> -1. About this guide
> +===========================================
> +The PCI Express Port Bus Driver Guide HOWTO
> +===========================================
> +
> +:Author: Tom L Nguyen tom.l.nguyen@intel.com 11/03/2004
> +:Copyright: |copy| 2004 Intel Corporation
> +
> +About this guide
> +================
>  
>  This guide describes the basics of the PCI Express Port Bus driver
>  and provides information on how to enable the service drivers to
>  register/unregister with the PCI Express Port Bus Driver.
>  
> -2. Copyright 2004 Intel Corporation
>  
> -3. What is the PCI Express Port Bus Driver
> +What is the PCI Express Port Bus Driver
> +=======================================
>  
>  A PCI Express Port is a logical PCI-PCI Bridge structure. There
>  are two types of PCI Express Port: the Root Port and the Switch
> @@ -30,7 +37,8 @@ support (AER), and virtual channel support (VC). These services may
>  be handled by a single complex driver or be individually distributed
>  and handled by corresponding service drivers.
>  
> -4. Why use the PCI Express Port Bus Driver?
> +Why use the PCI Express Port Bus Driver?
> +========================================
>  
>  In existing Linux kernels, the Linux Device Driver Model allows a
>  physical device to be handled by only a single driver. The PCI
> @@ -51,28 +59,31 @@ PCI Express Ports and distributes all provided service requests
>  to the corresponding service drivers as required. Some key
>  advantages of using the PCI Express Port Bus driver are listed below:
>  
> -	- Allow multiple service drivers to run simultaneously on
> -	  a PCI-PCI Bridge Port device.
> +  - Allow multiple service drivers to run simultaneously on
> +    a PCI-PCI Bridge Port device.
>  
> -	- Allow service drivers implemented in an independent
> -	  staged approach.
> +  - Allow service drivers implemented in an independent
> +    staged approach.
>  
> -	- Allow one service driver to run on multiple PCI-PCI Bridge
> -	  Port devices.
> +  - Allow one service driver to run on multiple PCI-PCI Bridge
> +    Port devices.
>  
> -	- Manage and distribute resources of a PCI-PCI Bridge Port
> -	  device to requested service drivers.
> +  - Manage and distribute resources of a PCI-PCI Bridge Port
> +    device to requested service drivers.
>  
> -5. Configuring the PCI Express Port Bus Driver vs. Service Drivers
> +Configuring the PCI Express Port Bus Driver vs. Service Drivers
> +===============================================================
>  
> -5.1 Including the PCI Express Port Bus Driver Support into the Kernel
> +Including the PCI Express Port Bus Driver Support into the Kernel
> +-----------------------------------------------------------------
>  
>  Including the PCI Express Port Bus driver depends on whether the PCI
>  Express support is included in the kernel config. The kernel will
>  automatically include the PCI Express Port Bus driver as a kernel
>  driver when the PCI Express support is enabled in the kernel.
>  
> -5.2 Enabling Service Driver Support
> +Enabling Service Driver Support
> +-------------------------------
>  
>  PCI device drivers are implemented based on Linux Device Driver Model.
>  All service drivers are PCI device drivers. As discussed above, it is
> @@ -89,9 +100,11 @@ header file /include/linux/pcieport_if.h, before calling these APIs.
>  Failure to do so will result an identity mismatch, which prevents
>  the PCI Express Port Bus driver from loading a service driver.
>  
> -5.2.1 pcie_port_service_register
> +pcie_port_service_register
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +::
>  
> -int pcie_port_service_register(struct pcie_port_service_driver *new)
> +  int pcie_port_service_register(struct pcie_port_service_driver *new)
>  
>  This API replaces the Linux Driver Model's pci_register_driver API. A
>  service driver should always calls pcie_port_service_register at
> @@ -99,69 +112,76 @@ module init. Note that after service driver being loaded, calls
>  such as pci_enable_device(dev) and pci_set_master(dev) are no longer
>  necessary since these calls are executed by the PCI Port Bus driver.
>  
> -5.2.2 pcie_port_service_unregister
> +pcie_port_service_unregister
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +::
>  
> -void pcie_port_service_unregister(struct pcie_port_service_driver *new)
> +  void pcie_port_service_unregister(struct pcie_port_service_driver *new)
>  
>  pcie_port_service_unregister replaces the Linux Driver Model's
>  pci_unregister_driver. It's always called by service driver when a
>  module exits.
>  
> -5.2.3 Sample Code
> +Sample Code
> +~~~~~~~~~~~
>  
>  Below is sample service driver code to initialize the port service
>  driver data structure.
> +::
>  
> -static struct pcie_port_service_id service_id[] = { {
> -	.vendor = PCI_ANY_ID,
> -	.device = PCI_ANY_ID,
> -	.port_type = PCIE_RC_PORT,
> -	.service_type = PCIE_PORT_SERVICE_AER,
> -	}, { /* end: all zeroes */ }
> -};
> +  static struct pcie_port_service_id service_id[] = { {
> +    .vendor = PCI_ANY_ID,
> +    .device = PCI_ANY_ID,
> +    .port_type = PCIE_RC_PORT,
> +    .service_type = PCIE_PORT_SERVICE_AER,
> +    }, { /* end: all zeroes */ }
> +  };
>  
> -static struct pcie_port_service_driver root_aerdrv = {
> -	.name		= (char *)device_name,
> -	.id_table	= &service_id[0],
> +  static struct pcie_port_service_driver root_aerdrv = {
> +    .name		= (char *)device_name,
> +    .id_table	= &service_id[0],
>  
> -	.probe		= aerdrv_load,
> -	.remove		= aerdrv_unload,
> +    .probe		= aerdrv_load,
> +    .remove		= aerdrv_unload,
>  
> -	.suspend	= aerdrv_suspend,
> -	.resume		= aerdrv_resume,
> -};
> +    .suspend	= aerdrv_suspend,
> +    .resume		= aerdrv_resume,
> +  };
>  
>  Below is a sample code for registering/unregistering a service
>  driver.
> +::
>  
> -static int __init aerdrv_service_init(void)
> -{
> -	int retval = 0;
> +  static int __init aerdrv_service_init(void)
> +  {
> +    int retval = 0;
>  
> -	retval = pcie_port_service_register(&root_aerdrv);
> -	if (!retval) {
> -		/*
> -		 * FIX ME
> -		 */
> -	}
> -	return retval;
> -}
> +    retval = pcie_port_service_register(&root_aerdrv);
> +    if (!retval) {
> +      /*
> +      * FIX ME
> +      */
> +    }
> +    return retval;
> +  }
>  
> -static void __exit aerdrv_service_exit(void)
> -{
> -	pcie_port_service_unregister(&root_aerdrv);
> -}
> +  static void __exit aerdrv_service_exit(void)
> +  {
> +    pcie_port_service_unregister(&root_aerdrv);
> +  }
>  
> -module_init(aerdrv_service_init);
> -module_exit(aerdrv_service_exit);
> +  module_init(aerdrv_service_init);
> +  module_exit(aerdrv_service_exit);
>  
> -6. Possible Resource Conflicts
> +Possible Resource Conflicts
> +===========================
>  
>  Since all service drivers of a PCI-PCI Bridge Port device are
>  allowed to run simultaneously, below lists a few of possible resource
>  conflicts with proposed solutions.
>  
> -6.1 MSI and MSI-X Vector Resource
> +MSI and MSI-X Vector Resource
> +-----------------------------
>  
>  Once MSI or MSI-X interrupts are enabled on a device, it stays in this
>  mode until they are disabled again.  Since service drivers of the same
> @@ -179,7 +199,8 @@ driver. Service drivers should use (struct pcie_device*)dev->irq to
>  call request_irq/free_irq. In addition, the interrupt mode is stored
>  in the field interrupt_mode of struct pcie_device.
>  
> -6.3 PCI Memory/IO Mapped Regions
> +PCI Memory/IO Mapped Regions
> +----------------------------
>  
>  Service drivers for PCI Express Power Management (PME), Advanced
>  Error Reporting (AER), Hot-Plug (HP) and Virtual Channel (VC) access
> @@ -188,7 +209,8 @@ registers accessed are independent of each other. This patch assumes
>  that all service drivers will be well behaved and not overwrite
>  other service driver's configuration settings.
>  
> -6.4 PCI Config Registers
> +PCI Config Registers
> +--------------------
>  
>  Each service driver runs its PCI config operations on its own
>  capability structure except the PCI Express capability structure, in
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 7babf43709b0..452723318405 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -9,3 +9,4 @@ Linux PCI Bus Subsystem
>     :numbered:
>  
>     pci
> +   PCIEBUS-HOWTO



Thanks,
Mauro
