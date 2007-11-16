Return-Path: <geert@linux-m68k.org>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id B5B80DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 20:44:30 +1100 (EST)
Date: Fri, 16 Nov 2007 10:44:28 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonytel.be
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] remove dead MAC_ADBKEYCODES
In-Reply-To: <1195142010.14001.21.camel@hammer.suse.cz>
Message-ID: <Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
References: <1195142010.14001.21.camel@hammer.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-input@atrey.karlin.mff.cuni.cz,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Wrong mailing list ;-)

On Thu, 15 Nov 2007, Stanislav Brabec wrote:
> It seems, that current kernel source code contains no traces of
> MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
> more.
> 
> Attached patch removes them from configuration files.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -582,20 +582,6 @@ config MAC_HID
>  	depends on INPUT_ADBHID
>  	default y
>  
> -config MAC_ADBKEYCODES
> -	bool "Support for ADB raw keycodes"
> -	depends on INPUT_ADBHID
> -	help
> -	  This provides support for sending raw ADB keycodes to console
> -	  devices.  This is the default up to 2.4.0, but in future this may be
> -	  phased out in favor of generic Linux keycodes.  If you say Y here,
> -	  you can dynamically switch via the
> -	  /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
> -	  sysctl and with the "keyboard_sends_linux_keycodes=" kernel
> -	  argument.
> -
> -	  If unsure, say Y here.
> -
>  config ADB_KEYBOARD
>  	bool "Support for ADB keyboard (old driver)"
>  	depends on MAC && !INPUT_ADBHID
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -678,7 +678,6 @@ CONFIG_LOGO_MAC_CLUT224=y
>  #
>  CONFIG_MAC_SCC=y
>  CONFIG_MAC_HID=y
> -CONFIG_MAC_ADBKEYCODES=y
>  CONFIG_SERIAL_CONSOLE=y
>  
>  #
> 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
