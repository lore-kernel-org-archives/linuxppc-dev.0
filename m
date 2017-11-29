Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5DY0D9szDrb5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:13:16 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vATGAVb1003558
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 11:13:14 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ehxp1cy83-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 11:13:13 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 29 Nov 2017 11:13:13 -0500
Subject: Re: [PATCH v5 0/3] Prepartion for SR-IOV PowerVM Enablement
To: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 10:13:07 -0600
MIME-Version: 1.0
In-Reply-To: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8f9ebacd-5e4e-a6d3-b1c2-dcf9bd0ea811@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/9/17 8:00 AM, Bryant G. Ly wrote:

> v1 - Initial patch
> v2 - Addressed Bjorn's comment on creating a highly platform
>      dependent global exported symbol.
> v3 - Based patch off linux-ppc/master
> v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request
> v5 - Fixed comments and commit message
>
> Bryant G. Ly (3):
>   powerpc/kernel: Separate SR-IOV Calls
>   pseries: Add PSeries SR-IOV Machine dependent calls
>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
>
>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>  arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci.c         | 31 ++++++++++++++++++++++----
>  drivers/pci/iov.c                            | 11 ++++++++++
>  include/linux/pci.h                          |  2 ++
>  11 files changed, 118 insertions(+), 33 deletions(-)
>
Hi Mike,

Any updates on when this is going to get pulled? I want to submit the full SR-IOV enablement on PowerVM,
but I haven't seen this get merged into 4.15 yet.

-Bryant
