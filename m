Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0818568863
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 07:14:39 +1100 (EST)
Date: Thu, 1 Dec 2005 21:14:35 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Olaf Hering <olh@suse.de>, Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20051201201010.GA2741@suse.de>
Message-ID: <Pine.LNX.4.62.0512012113190.17317@pademelon.sonytel.be>
References: <20051201201010.GA2741@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: correct the NR_CPUS description text
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 1 Dec 2005, Olaf Hering wrote:
> Update the help text to match the allowed range.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  arch/powerpc/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.15-rc4-olh.orig/arch/powerpc/Kconfig
> +++ linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
> @@ -227,7 +227,7 @@ config SMP
>  	  If you don't know what to do here, say N.
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> +	int "Maximum number of CPUs (2-128)"
>  	range 2 128
>  	depends on SMP
>  	default "32" if PPC64

Shouldn't kconfig (be enhanced to) add the range to the help text
automatically, to avoid problems like this?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
