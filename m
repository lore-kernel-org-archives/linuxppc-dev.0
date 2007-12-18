Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 19631DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 13:43:27 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3831827wag.13
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 18:43:26 -0800 (PST)
Message-ID: <9e4733910712171843u579c34efia53d0571a782dd19@mail.gmail.com>
Date: Mon, 17 Dec 2007 21:43:26 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Makefile
In-Reply-To: <20071218023928.8530.25171.stgit@terra.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071218023913.8530.46661.stgit@terra.home>
	<20071218023928.8530.25171.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ignore this patch, I forgot to remove it before mailing the series.

On 12/17/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
>
>  Makefile |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
>
> diff --git a/Makefile b/Makefile
> index c1825aa..15ada3f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -35,6 +35,9 @@ MAKEFLAGS += -rR --no-print-directory
>  # To put more focus on warnings, be less verbose as default
>  # Use 'make V=1' to see the full commands
>
> +ARCH=powerpc
> +CROSS_COMPILE=powerpc-603e-linux-gnu-
> +
>  ifdef V
>    ifeq ("$(origin V)", "command line")
>      KBUILD_VERBOSE = $(V)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Jon Smirl
jonsmirl@gmail.com
