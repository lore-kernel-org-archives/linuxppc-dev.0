Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A3A21A0A6C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 03:13:32 +1000 (EST)
Message-ID: <1407518003.26210.13.camel@ul30vt.home>
Subject: Re: [PATCH v4 0/5] drivers/vfio: EEH Compile and compatibility
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 08 Aug 2014 11:13:23 -0600
In-Reply-To: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-07 at 12:47 +1000, Gavin Shan wrote:
> The patchset is mainly for fixing errors from building VFIO compoments
> as dynamic modules. PATCH[4/4] allows VFIO can be used though EEH fails
> to initialize for VFIO PCI devices.
> 
> 
> Alexey Kardashevskiy (2):
>   drivers/vfio: Allow EEH to be built as module
>   drivers/vfio: Enable VFIO if EEH is not supported
> 
> Gavin Shan (3):
>   powerpc/eeh: Export eeh_iommu_group_to_pe()
>   powerpc/eeh: Add warning message in eeh_dev_open()
>   drivers/vfio: Fix EEH build error
> 
>  arch/powerpc/kernel/eeh.c     |  6 +++++-
>  drivers/vfio/Kconfig          |  6 ++++++
>  drivers/vfio/Makefile         |  2 +-
>  drivers/vfio/pci/vfio_pci.c   |  6 +-----
>  drivers/vfio/vfio_spapr_eeh.c | 17 +++++++++++++++--
>  include/linux/vfio.h          |  6 +++---
>  6 files changed, 31 insertions(+), 12 deletions(-)

Applied 3-5 to vfio next branch for 3.17.  Thanks,

Alex
