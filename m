Return-Path: <ruscur@russell.cc>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkB1P1LPhzDqrL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 14:36:57 +1000 (AEST)
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkB1P0DcJz9sXy
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 14:36:57 +1000 (AEST)
Message-ID: <1467693015.23386.1.camel@russell.cc>
Subject: Re: [PATCH] powerpc/pci: Fix build with PCI_IOV=y and EEH=n
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Tue, 05 Jul 2016 14:30:15 +1000
In-Reply-To: <1467692010-12512-1-git-send-email-mpe@ellerman.id.au>
References: <1467692010-12512-1-git-send-email-mpe@ellerman.id.au>
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

On Tue, 2016-07-05 at 14:13 +1000, Michael Ellerman wrote:
> Despite attempting to fix this in commit fb36e9073693 ("powerpc/pci: Fix
> SRIOV not building without EEH enabled"), the build is still broken when
> PCI_IOV=y and EEH=n (eg. g5_defconfig with PCI_IOV=y):
> 
>   arch/powerpc/kernel/pci_dn.c: In function ‘remove_dev_pci_data’:
>   arch/powerpc/kernel/pci_dn.c:230:18: error: unused variable ‘edev’
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Mistakes were made.

Acked-by: Russell Currey <ruscur@russell.cc>
