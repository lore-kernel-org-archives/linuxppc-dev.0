Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C127D2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 09:05:48 +1100 (EST)
Message-ID: <50983834.30403@freescale.com>
Date: Mon, 5 Nov 2012 16:05:40 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
References: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: scottwood@freescale.com, joerg.roedel@amd.com,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Varun Sethi wrote:
> This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
> and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
> QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
> the I/O transaction type.

You forgot to send post these patches to
linuxppc-release@linux.freescale.net.  May I suggest the following

git-send-email ... --bcc linuxppc-release@linux.freescale.net ...

whenever you post a patch upstream?

> This set consists of the following patches:
> 1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
>    pointer. This pointer is stored when the device is attached to a particular iommu domain.
> 2. Add PAMU bypass enable register to the ccsr_guts structure.

I don't see patch 2/4 posted anywhere.

-- 
Timur Tabi
Linux kernel developer at Freescale
