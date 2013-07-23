Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id 48A582C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 07:23:20 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [PATCH 2/2] cpuidle: export cpuidle_idle_call symbol
Date: Tue, 23 Jul 2013 23:33:22 +0200
Message-ID: <16375354.KJ7QhjYo9F@vostro.rjw.lan>
In-Reply-To: <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
 <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 23, 2013 05:28:01 PM Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Export cpuidle_idle_call symbol, make this function can be invoked
> in the module.

Why?

Rafael


> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> Branch: pm-cpuidle
> 
>  drivers/cpuidle/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 534320a..d0a61d6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -168,6 +168,7 @@ int cpuidle_idle_call(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_idle_call);
>  
>  /**
>   * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
