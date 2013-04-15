Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 112762C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 00:58:43 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 22B7A12AF92
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 16:58:37 +0200 (CEST)
Date: Mon, 15 Apr 2013 16:58:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
Message-ID: <20130415145834.GR6858@8bytes.org>
References: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
Cc: linux-kernel@vger.kernel.org, stuart.yoder@freescale.com,
 bhelgaas@google.com, iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 15, 2013 at 12:42:00AM +0530, Varun Sethi wrote:
> swap_pci_ref function is used by the IOMMU API code for swapping pci device
> pointers, while determining the iommu group for the device.
> Currently this function was being implemented for different IOMMU drivers.
> This patch moves the function to pci.h so that the implementation can be
> shared across various IOMMU drivers.

The function is only used in IOMMU code, so I think its fine to keep it
there (unless Bjorn disagrees and wants it in PCI code).


	Joerg
