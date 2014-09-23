Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1371A0199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 07:02:00 +1000 (EST)
Received: by mail-ig0-f181.google.com with SMTP id h18so5340866igc.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 14:01:57 -0700 (PDT)
Date: Tue, 23 Sep 2014 15:01:54 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH v2 0/3] PCI/MSI: Remove arch_msi_check_device()
Message-ID: <20140923210154.GB27117@google.com>
References: <cover.1410078503.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1410078503.git.agordeev@redhat.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 07, 2014 at 08:57:52PM +0200, Alexander Gordeev wrote:
> Hello,
> 
> This is a cleanup effort to get rid of arch_msi_check_device() function.
> 
> I am sending v2 series, since kbuild for v1 reports compile errors on
> ppc4xx and Armada 370. Still, I have not checked the fixes on these
> platforms.
> 
> Changes since v1:
>   - patch 1: 'pdev' undeclared compile error fixed on ppc4xx. I updated
>              changelog and removed ACK from this patch in case there are
>              any objections;
> 
>   - patch 2: 'struct msi_chip' has no 'check_device' error fixed on
>              Armada 370 - armada_370_xp_check_msi_device() hook removed;
> 
>   - patch 3: msi_check_device() renamed to pci_msi_supported(). This is
>              the very same patch I sent earlier;
> 
> Thanks!
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> 
> Alexander Gordeev (3):
>   patch 1 - PCI/MSI/PPC: Remove arch_msi_check_device()
>   patch 2 - PCI/MSI/Armada-370-xp: Remove arch_msi_check_device()
>   patch 3 - PCI/MSI: Remove arch_msi_check_device()

Applied (with some changes to 3/3) to pci/msi for v3.18, thanks!  Let me
know if you see any issues.

Bjorn
