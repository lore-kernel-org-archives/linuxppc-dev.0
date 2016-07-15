Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrXwq1z09zDqyS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:10:03 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so2681689pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 06:10:03 -0700 (PDT)
Date: Fri, 15 Jul 2016 23:10:31 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org,
 mikey@neuling.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v7 01/11] powerpc/powernv: Use PNV_THREAD_WINKLE macro
 while requesting for winkle
Message-ID: <20160715131031.GC21685@350D>
Reply-To: bsingharora@gmail.com
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467924432-29003-2-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467924432-29003-2-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2016 at 02:17:02AM +0530, Shreyas B. Prabhu wrote:
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> -No changes since v4
> 
> Changes in v4
> =============
> - New in v4
> 
>  arch/powerpc/kernel/idle_power7.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
> index 470ceeb..705c867 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -252,7 +252,7 @@ _GLOBAL(power7_sleep)
>  	/* No return */
>  
>  _GLOBAL(power7_winkle)
> -	li	r3,3
> +	li	r3,PNV_THREAD_WINKLE
>  	li	r4,1
>  	b	power7_powersave_common

Acked-by: Balbir Singh <bsingharora@gmail.com>
