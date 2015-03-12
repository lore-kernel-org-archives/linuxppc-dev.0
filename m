Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
 [209.85.217.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC97C1A078D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 05:53:02 +1100 (AEDT)
Received: by lbiz12 with SMTP id z12so18041372lbi.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 11:52:59 -0700 (PDT)
Message-ID: <5501E088.6020502@cogentembedded.com>
Date: Thu, 12 Mar 2015 21:52:56 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Karsten Keil <isdn@linux-pingi.de>
Subject: Re: [PATCH 7/8] isdn: replace CONFIG_8xx by CONFIG_PPC_8xx
References: <20150312152409.E7B5C1A2422@localhost.localdomain>
In-Reply-To: <20150312152409.E7B5C1A2422@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 user-mode-linux-user@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 03/12/2015 06:24 PM, Christophe Leroy wrote:

> Two config options exist to define powerpc MPC8xx:
> * CONFIG_PPC_8xx
> * CONFIG_8xx
> In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
> communication co-processor

> arch/powerpc/platforms/Kconfig.cputype has contained the following
> comment about CONFIG_8xx item for some years:
> "# this is temp to handle compat with arch=ppc"

> It looks like not many places still have that old CONFIG_8xx used,
> so it is likely to be a good time to get rid of it completely ?

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

[...]

> diff --git a/drivers/isdn/hardware/mISDN/Kconfig b/drivers/isdn/hardware/mISDN/Kconfig
> index 09df54f..ad9deab 100644
> --- a/drivers/isdn/hardware/mISDN/Kconfig
> +++ b/drivers/isdn/hardware/mISDN/Kconfig
[...]
> @@ -28,7 +28,7 @@ config MISDN_HFCMULTI_8xx
>   	depends on MISDN
>   	depends on MISDN_HFCMULTI
>   	depends on 8xx

    Eh, how about this one?

> -	default 8xx
> +	default PPC_8xx
>   	help
>   	  Enable support for the XHFC embedded solution from Speech Design.

WBR, Sergei
