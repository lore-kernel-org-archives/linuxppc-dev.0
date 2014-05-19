Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A50041A007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 22:51:31 +1000 (EST)
Message-ID: <5379FE4F.6070706@suse.de>
Date: Mon, 19 May 2014 14:51:27 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 3/8] drivers/vfio: New IOCTL command VFIO_EEH_INFO
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400040722-29608-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.05.14 06:11, Gavin Shan wrote:
> The patch adds new IOCTL command VFIO_EEH_INFO to VFIO container
> to support EEH functionality for PCI devices, which have been
> passed from host to guest via VFIO.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/Makefile   |   1 +
>   arch/powerpc/platforms/powernv/eeh-vfio.c | 593 ++++++++++++++++++++++++++++++
>   drivers/vfio/vfio_iommu_spapr_tce.c       |  12 +
>   include/uapi/linux/vfio.h                 |  57 +++

Documentation/...?


Alex
