Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id AD098DDF28
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 19:20:46 +1100 (EST)
Date: Mon, 3 Nov 2008 09:20:45 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] cell: fix ras.c compilation
In-Reply-To: <20081102202157.GA11316@x200.localdomain>
Message-ID: <Pine.LNX.4.64.0811030920310.11062@vixen.sonytel.be>
References: <20081102202157.GA11316@x200.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1488087455-1225700445=:11062"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1488087455-1225700445=:11062
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 2 Nov 2008, Alexey Dobriyan wrote:
> arch/powerpc/platforms/cell/ras.c:299: error: implicit declaration of function 'crash_shutdown_register'
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/powerpc/platforms/cell/ras.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/powerpc/platforms/cell/ras.c
> +++ b/arch/powerpc/platforms/cell/ras.c
> @@ -16,6 +16,7 @@
>  #include <linux/kexec.h>
>  #include <linux/crash_dump.h>
>  
> +#include <asm/kexec.h>

#include <linux/kexec.h>?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1488087455-1225700445=:11062--
