Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425r1L4cd5zF3Rf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 05:17:23 +1000 (AEST)
Date: Thu, 6 Sep 2018 14:17:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add maintainer entries for RPA pci hotplug
 drivers
Message-ID: <20180906191720.GG214747@bhelgaas-glaptop.roam.corp.google.com>
References: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2018 at 06:20:31PM -0700, Tyrel Datwyler wrote:
> Adding myself as maintiner of the IBM RPA hotplug modules located in
> drivers/pci/hotplug directory. These modules provide kernel interfaces
> for support of Dynamic Logical Partitioning (DLPAR) of Logical and
> Physical IO slots, and hotplug of physical PCI slots of a PHB on
> RPA-compliant ppc64 platforms (pseries).
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to for-linus for v4.19, thanks!

> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5df1b36..7b5dc3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6984,6 +6984,20 @@ F:	drivers/crypto/vmx/aes*
>  F:	drivers/crypto/vmx/ghash*
>  F:	drivers/crypto/vmx/ppc-xlate.pl
>  
> +IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
> +M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/pci/hotplug/rpaphp*
> +
> +IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
> +M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/pci/hotplug/rpadlpar*
> +
>  IBM ServeRAID RAID DRIVER
>  S:	Orphan
>  F:	drivers/scsi/ips.*
> -- 
> 1.8.3.1
> 
