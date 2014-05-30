Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38DE91A06CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 07:19:26 +1000 (EST)
Message-ID: <1401484751.6603.217.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc/t2080rdb: Add T2080RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 30 May 2014 16:19:11 -0500
In-Reply-To: <1400833623-17547-3-git-send-email-Shengzhou.Liu@freescale.com>
References: <1400833623-17547-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1400833623-17547-3-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-23 at 16:27 +0800, Shengzhou Liu wrote:
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index e3578b7..a8a0f2f 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -259,7 +259,7 @@ config CORENET_GENERIC
>  	  For 32bit kernel, the following boards are supported:
>  	    P2041 RDB, P3041 DS and P4080 DS
>  	  For 64bit kernel, the following boards are supported:
> -	    T208x QDS, T4240 QDS and B4 QDS
> +	    T208x QDS/RDB, T4240 QDS and B4 QDS

Apparently you meant for this to be applied after the QDS patch --
please ensure patches within a set are numbered.

-Scott
