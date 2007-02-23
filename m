Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 0195CDDD06
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 09:52:42 +1100 (EST)
Date: Fri, 23 Feb 2007 23:44:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Linux-fbdev-devel] linux 2.6.21-rc1 : FB Kconfig error
In-Reply-To: <Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0702232343330.14457@scrub.home>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702220052020.14457@scrub.home>
	<Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	=?UTF-8?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, 22 Feb 2007, Geert Uytterhoeven wrote:

> Like this?
> 
> Subject: ps3: Introduce CONFIG_PS3_ADVANCED

Looks good.

> --- ps3-linux-2.6.21-rc1.orig/arch/powerpc/platforms/ps3/Kconfig
> +++ ps3-linux-2.6.21-rc1/arch/powerpc/platforms/ps3/Kconfig
> @@ -1,9 +1,25 @@
>  menu "PS3 Platform Options"
>  	depends on PPC_PS3
>  
> +config PS3_ADVANCED
> +	depends on PPC_PS3
> +	bool "PS3 Advanced configuration options"
> +	default n

except that this default is not really necessary.

bye, Roman
