Return-Path: <jwboyer@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEE152C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 22:14:03 +1000 (EST)
Received: by mail-ob0-f181.google.com with SMTP id wo10so1272073obc.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2013 05:13:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365420434.1830.94.camel@x61.thuisdomein>
References: <1365420434.1830.94.camel@x61.thuisdomein>
Date: Mon, 8 Apr 2013 08:13:59 -0400
Message-ID: <CA+5PVA6B5Q8kEEUv4XohUWOjWGyEGhWFiJpe82hMfNiLVfV1sA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove unused "config 405EP"
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

On Mon, Apr 8, 2013 at 7:27 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> All users of Kconfig symbol 405EP were removed in release v2.6.27.
> Remove this symbol (and a useless select of it) too.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Josh Boyer <jwboyer@gmail.com>

> ---
> 0) Tested by grepping the tree only.
>
> 1) There's also a Kconfig symbol EP405. Let's hope no one ever made a
> typo with either of these two symbols!
>
>  arch/powerpc/platforms/40x/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> index 7b7a77c..bd40bbb 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -20,7 +20,6 @@ config HOTFOOT
>          bool "Hotfoot"
>         depends on 40x
>         default n
> -       select 405EP
>         select PPC40x_SIMPLE
>         select PCI
>          help
> @@ -105,9 +104,6 @@ config 405GP
>         select IBM405_ERR51
>         select IBM_EMAC_ZMII
>
> -config 405EP
> -       bool
> -
>  config 405EX
>         bool
>         select IBM_EMAC_EMAC4
> --
> 1.7.11.7
>
