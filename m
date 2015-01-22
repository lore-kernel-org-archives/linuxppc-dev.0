Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 738241A0DB0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 12:05:32 +1100 (AEDT)
Message-ID: <1421888731.4598.1.camel@ellerman.id.au>
Subject: Re: [PATCH resend] powernv/iommu: disable IOMMU bypass with param
 iommu=nobypass
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Date: Thu, 22 Jan 2015 12:05:31 +1100
In-Reply-To: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
References: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 13:23 -0200, Thadeu Lima de Souza Cascardo wrote:
> When IOMMU bypass is enabled, a PCI device can read and write memory
> that was not mapped by the driver without causing an EEH. That might
> cause memory corruption, for example.
> 
> When we disable bypass, DMA reads and writes to addresses not mapped by
> the IOMMU will cause an EEH, allowing us to debug such issues.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  Documentation/kernel-parameters.txt       |    2 ++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)

Is this unchanged since v2?

It's marked as under review in patchwork which means I'm looking at it:

  http://patchwork.ozlabs.org/patch/402682/


Please check patchwork in future.

cheers
