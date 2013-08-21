Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x236.google.com (mail-ee0-x236.google.com
 [IPv6:2a00:1450:4013:c00::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDC7D2C0103
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 17:26:47 +1000 (EST)
Received: by mail-ee0-f54.google.com with SMTP id e53so36798eek.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 00:26:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 21 Aug 2013 09:26:40 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC
 help texts
Message-ID: <20130821072640.GA27495@gmail.com>
References: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, x86@kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
> CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but missed
> a few plain English references in the CONFIG_KEXEC help texts.
> 
> Remove them, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/arm/Kconfig     |    3 +--
>  arch/ia64/Kconfig    |    6 +++---
>  arch/mips/Kconfig    |    6 +++---
>  arch/powerpc/Kconfig |    6 +++---
>  arch/sh/Kconfig      |    6 +++---
>  arch/x86/Kconfig     |    6 +++---
>  6 files changed, 16 insertions(+), 17 deletions(-)
[...]
>  	bool "kernel crash dumps (EXPERIMENTAL)"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b32ebf9..6ace5de 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1627,9 +1627,9 @@ config KEXEC
>  
>  	  It is an ongoing process to be certain the hardware in a machine
>  	  is properly shutdown, so do not be surprised if this code does not
> -	  initially work for you.  It may help to enable device hotplugging
> -	  support.  As of this writing the exact hardware interface is
> -	  strongly in flux, so no good recommendation can be made.
> +	  initially work for you.  As of this writing the exact hardware
> +	  interface is strongly in flux, so no good recommendation can be
> +	  made.
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
