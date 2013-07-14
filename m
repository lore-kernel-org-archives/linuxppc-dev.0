Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 576C22C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 08:01:36 +1000 (EST)
Message-ID: <1373839281.19894.272.camel@pasglop>
Subject: Re: [PATCH] powerpc/pseries: drop "select HOTPLUG"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Mon, 15 Jul 2013 08:01:21 +1000
In-Reply-To: <1373799735.1370.5.camel@x61.thuisdomein>
References: <1373799735.1370.5.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-07-14 at 13:02 +0200, Paul Bolle wrote:
> The Kconfig symbol HOTPLUG was removed with commit 40b313608a ("Finally
> eradicate CONFIG_HOTPLUG"). But there's still one select statement for
> that symbol. It seems that select statement was added after the patch to
> remove CONFIG_HOTPLUG was submitted. Anyhow, it is useless and can be
> dropped.

Thanks. I'll apply.

Ben.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Not tested.
> 
>  arch/powerpc/platforms/pseries/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 1bd3399..62b4f80 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -19,7 +19,6 @@ config PPC_PSERIES
>  	select ZLIB_DEFLATE
>  	select PPC_DOORBELL
>  	select HAVE_CONTEXT_TRACKING
> -	select HOTPLUG if SMP
>  	select HOTPLUG_CPU if SMP
>  	default y
>  
