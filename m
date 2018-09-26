Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L7DX2t1DzF3MZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 05:24:44 +1000 (AEST)
Date: Wed, 26 Sep 2018 14:24:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI/AER: Remove duplicated include from err.c
Message-ID: <20180926192440.GC28024@bhelgaas-glaptop.roam.corp.google.com>
References: <1537959610-71713-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537959610-71713-1-git-send-email-yuehaibing@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2018 at 11:00:10AM +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to pci/hotplug for v4.20, thanks!

> ---
>  drivers/pci/pcie/err.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 4da2a62b..773197a 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/pci.h>
>  #include <linux/module.h>
> -#include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/aer.h>
> 
> 
> 
