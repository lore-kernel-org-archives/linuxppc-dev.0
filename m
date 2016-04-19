Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq0R64WV2zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:42:10 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id zm5so5132124pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:42:10 -0700 (PDT)
Subject: Re: [PATCH v8 39/45] powerpc/powernv: Select OF_DYNAMIC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-40-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715FD69.3060302@ozlabs.ru>
Date: Tue, 19 Apr 2016 19:42:01 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-40-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> The device tree will change dynamically in PowerNV PCI hotplug
> driver. This enables CONFIG_OF_DYNAMIC to support that.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index 604190c..e7b1ad7 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -18,6 +18,7 @@ config PPC_POWERNV
>   	select CPU_FREQ_GOV_ONDEMAND
>   	select CPU_FREQ_GOV_CONSERVATIVE
>   	select PPC_DOORBELL
> +	select OF_DYNAMIC


Why not to enable it in 45/45 under config HOTPLUG_PCI_POWERNV? Is there 
any benefit of having it always on if HOTPLUG_PCI_POWERNV is not enabled?


>   	default y
>
>   config OPAL_PRD
>


-- 
Alexey
