Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id CB8782C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 22:33:39 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id BEC1C12AEE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 12:33:37 +0100 (CET)
Date: Wed, 27 Feb 2013 12:33:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 3/6] powerpc/fsl_pci: Added defines for the FSL PCI
 controller BRR1 register.
Message-ID: <20130227113336.GI26252@8bytes.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-4-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361191939-21260-4-git-send-email-Varun.Sethi@freescale.com>
Cc: scottwood@freescale.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stuart.yoder@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2013 at 06:22:16PM +0530, Varun Sethi wrote:
> Macros for checking FSL PCI controller version.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
>  arch/powerpc/include/asm/pci-bridge.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 025a130..c12ed78 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -14,6 +14,10 @@
>  
>  struct device_node;
>  
> +/* FSL PCI controller BRR1 register */
> +#define PCI_FSL_BRR1      0xbf8
> +#define PCI_FSL_BRR1_VER 0xffff
> +


Please merge this patch with the one where you actually make use of
these defines for the first time.


	Joerg
