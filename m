Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 96B4DB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2011 00:40:37 +1100 (EST)
Received: by vws20 with SMTP id 20so1099890vws.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 06:40:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318595400.6132.73.camel@x61.thuisdomein>
References: <1318595400.6132.73.camel@x61.thuisdomein>
Date: Fri, 14 Oct 2011 09:40:33 -0400
Message-ID: <CA+5PVA5T+XqY8CxoK7+_s0F6FPW+ey2tAssEHMOi7M4vHph+tA@mail.gmail.com>
Subject: Re: [PATCH 15/21] powerpc: drop unused Kconfig symbols
From: Josh Boyer <jwboyer@gmail.com>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2011 at 8:30 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 ----------------------
> =A0arch/powerpc/platforms/40x/Kconfig =A0 =A0 =A0 =A0 | =A0 =A05 -----
> =A0arch/powerpc/platforms/Kconfig.cputype =A0 =A0 | =A0 =A08 --------
> =A0arch/powerpc/platforms/embedded6xx/Kconfig | =A0 =A04 ----
> =A0arch/powerpc/platforms/prep/Kconfig =A0 =A0 =A0 =A0| =A0 =A09 --------=
-
> =A0arch/powerpc/platforms/wsp/Kconfig =A0 =A0 =A0 =A0 | =A0 =A05 -----
> =A06 files changed, 0 insertions(+), 53 deletions(-)

For the 40x change:

Acked-by: Josh Boyer <jwboyer@gmail.com>

josh

> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/=
40x/Kconfig
> index d733d7c..4bd3a27 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -115,11 +115,6 @@ config PPC40x_SIMPLE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option enables the simple PowerPC 40x platform su=
pport.
>
> -# 40x specific CPU modules, selected based on the board above.
> -config NP405H
> - =A0 =A0 =A0 bool
> - =A0 =A0 =A0 #depends on ASH
> -
> =A0# OAK doesn't exist but wanted to keep this around for any future 403G=
CX boards
> =A0config 403GCX
> =A0 =A0 =A0 =A0bool
>
