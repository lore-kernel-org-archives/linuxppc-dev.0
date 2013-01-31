Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1203E2C02BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 00:31:51 +1100 (EST)
Subject: Re: [PATCH 5/5] KVM: PPC: e500mc: Enable e6500 cores
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1359552584-17861-6-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 31 Jan 2013 14:31:46 +0100
Message-Id: <1ACC70B2-BA7C-4D9F-8D30-FDE9F7626187@suse.de>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-6-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.01.2013, at 14:29, Mihai Caraman wrote:

> Extend processor compatibility names to e6500 cores.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Looks good to me.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex

> ---
> arch/powerpc/kvm/e500mc.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 1f89d26..6c87299 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -172,6 +172,8 @@ int kvmppc_core_check_processor_compat(void)
> 		r = 0;
> 	else if (strcmp(cur_cpu_spec->cpu_name, "e5500") == 0)
> 		r = 0;
> +	else if (strcmp(cur_cpu_spec->cpu_name, "e6500") == 0)
> +		r = 0;
> 	else
> 		r = -ENOTSUPP;
> 
> -- 
> 1.7.4.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
