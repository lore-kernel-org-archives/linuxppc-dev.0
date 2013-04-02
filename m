Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 8E0EF2C013C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 03:23:17 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 98E0E12AFD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 18:23:14 +0200 (CEST)
Date: Tue, 2 Apr 2013 18:23:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 0/5 v11] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Message-ID: <20130402162310.GJ15687@8bytes.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
Cc: linux-kernel@vger.kernel.org, stuart.yoder@freescale.com,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 29, 2013 at 01:23:57AM +0530, Varun Sethi wrote:
> This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
> and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
> QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
> the I/O transaction type.
> 
> This set consists of the following patches:
> 1.  Make iova dma_addr_t in the iommu_iova_to_phys API.
> 2. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
>    pointer.
> 3. Add window permission flags in the iommu_domain_window_enable API.
> 4. Add domain attributes for FSL PAMU driver.
> 5. PAMU driver and IOMMU API implementation.

Okay, I am about to apply patches 1 and 3 to a new ppc/pamu branch in my
tree.

As a general question, how did you test the IOMMU driver and what will
you do in the future to avoid regressions?


	Joerg
