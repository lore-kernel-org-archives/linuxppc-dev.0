Return-Path: <jwboyer@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F08202C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:17:46 +1100 (EST)
Received: by mail-ob0-f182.google.com with SMTP id va7so2214240obc.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 07:17:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363268870.1335.75.camel@x61.thuisdomein>
References: <1363268870.1335.75.camel@x61.thuisdomein>
Date: Thu, 14 Mar 2013 10:17:41 -0400
Message-ID: <CA+5PVA6CzVZVDyQNzChddo7NV05EMgtqZw1xxBeA5oJzdqTLpA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: remove unused "config 405GPR"
From: Josh Boyer <jwboyer@gmail.com>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 14, 2013 at 9:47 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> The last user of Kconfig symbol 405GPR got removed in release v3.2.
> Remove this symbol too.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Josh Boyer <jwboyer@gmail.com>

> ---
>  arch/powerpc/platforms/40x/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> index a392d12..7b7a77c 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -119,9 +119,6 @@ config 405EZ
>         select IBM_EMAC_MAL_CLR_ICINTSTAT
>         select IBM_EMAC_MAL_COMMON_ERR
>
> -config 405GPR
> -       bool
> -
>  config XILINX_VIRTEX
>         bool
>         select DEFAULT_UIMAGE
> --
> 1.7.11.7
>
>
>
