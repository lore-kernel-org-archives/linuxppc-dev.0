Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id AAD3ADDDEF
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 19:20:34 +1100 (EST)
Date: Mon, 3 Nov 2008 09:20:28 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ps3: ps3-lpm.c compile fix
In-Reply-To: <20081102172650.GA7219@x200.localdomain>
Message-ID: <Pine.LNX.4.64.0811030920170.11062@vixen.sonytel.be>
References: <20081102172650.GA7219@x200.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-820058647-1225700428=:11062"
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

---584349381-820058647-1225700428=:11062
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 2 Nov 2008, Alexey Dobriyan wrote:
> drivers/ps3/ps3-lpm.c:838: error: implicit declaration of function 'get_hard_smp_processor_id'
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/ps3/ps3-lpm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/ps3/ps3-lpm.c
> +++ b/drivers/ps3/ps3-lpm.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/uaccess.h>
> +#include <asm/smp.h>

#include <linux/smp.h>?

>  #include <asm/time.h>
>  #include <asm/ps3.h>
>  #include <asm/lv1call.h>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

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
---584349381-820058647-1225700428=:11062--
