Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZvr5v0fzDrcc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 17:06:00 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i6so2703482pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 00:06:00 -0700 (PDT)
Date: Thu, 25 Aug 2016 17:05:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 08/12] powerpc: Introduce new mask bit for
 soft_enabled
Message-ID: <20160825170549.030a4387@roar.ozlabs.ibm.com>
In-Reply-To: <1472106603-23336-9-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472106603-23336-9-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Aug 2016 11:59:59 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index c19169ac1fbb..e457438c6fdf 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -32,6 +32,7 @@
>   */
>  #define IRQ_DISABLE_MASK_NONE		0
>  #define IRQ_DISABLE_MASK_LINUX		1
> +#define IRQ_DISABLE_MASK_PMU		2
>  
>  #endif /* CONFIG_PPC64 */

This bit belongs in patch 10, I think?
