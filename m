Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 1560FDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 17:50:04 +1000 (EST)
Date: Wed, 8 Aug 2007 09:49:58 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 2/3] PS3: Remove incomplete message
In-Reply-To: <20070808033120.055823394@am.sony.com>
Message-ID: <Pine.LNX.4.62.0708080949260.24807@pademelon.sonytel.be>
References: <20070808033119.833895506@am.sony.com>
	<20070808033120.055823394@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-424866318-1186559398=:24807"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-424866318-1186559398=:24807
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 7 Aug 2007 geoffrey.levand@am.sony.com wrote:
> Remove the Kconfig message that indicates the PS3 platform support is
> incomplete.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/platforms/ps3/Kconfig |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -1,5 +1,5 @@
>  config PPC_PS3
> -	bool "Sony PS3 (incomplete)"
> +	bool "Sony PS3"
>  	depends on PPC_MULTIPLATFORM && PPC64
>  	select PPC_CELL
>  	select USB_ARCH_HAS_OHCI
> @@ -10,10 +10,10 @@ config PPC_PS3
>  	select MEMORY_HOTPLUG
>  	help
>  	  This option enables support for the Sony PS3 game console
> -	  and other platforms using the PS3 hypervisor.
> -	  Support for this platform is not yet complete, so
> -	  enabling this will not result in a bootable kernel on a
> -	  PS3 system.
> +	  and other platforms using the PS3 hypervisor.  Enabling this
> +	  option will allow building otheros.bld, a kernel image suitable
> +	  for programming into flash memory, and vmlinux, a kernel image
> +	  suitable loading via kexec.
                  ^
		  for

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-424866318-1186559398=:24807--
