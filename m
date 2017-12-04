Return-Path: <ruscur@russell.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqspd086XzDqmH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 15:48:56 +1100 (AEDT)
Message-ID: <1512362926.1689.1.camel@russell.cc>
Subject: Re: [PATCH v5 0/3] Prepartion for SR-IOV PowerVM Enablement
From: Russell Currey <ruscur@russell.cc>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, helgaas@kernel.org,
 bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
Date: Mon, 04 Dec 2017 15:48:46 +1100
In-Reply-To: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-09 at 08:00 -0600, Bryant G. Ly wrote:
> v1 - Initial patch
> v2 - Addressed Bjorn's comment on creating a highly platform
>      dependent global exported symbol.
> v3 - Based patch off linux-ppc/master
> v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request
> v5 - Fixed comments and commit message

Looks good to me, for the whole series:

Acked-by: Russell Currey <ruscur@russell.cc>

> 
> Bryant G. Ly (3):
>   powerpc/kernel: Separate SR-IOV Calls
>   pseries: Add PSeries SR-IOV Machine dependent calls
>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
> 
>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>  arch/powerpc/kernel/pci-common.c             | 23
> +++++++++++++++++++
>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--
> ------------
>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24
> ++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci.c         | 31
> ++++++++++++++++++++++----
>  drivers/pci/iov.c                            | 11 ++++++++++
>  include/linux/pci.h                          |  2 ++
>  11 files changed, 118 insertions(+), 33 deletions(-)
> 
