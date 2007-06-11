Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 76A2FDDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 01:45:51 +1000 (EST)
Date: Mon, 11 Jun 2007 17:45:44 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 09/18] PS3: System-bus rework
In-Reply-To: <466D6CA7.3020709@am.sony.com>
Message-ID: <Pine.LNX.4.62.0706111744440.18685@pademelon.sonytel.be>
References: <c52d99b0071ef223a51612ce7d0cddea@bga.com>
	<466D6CA7.3020709@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Jun 2007, Geoff Levand wrote:
> Milton Miller wrote:
> >> --- a/arch/powerpc/platforms/ps3/mm.c
> >> +++ b/arch/powerpc/platforms/ps3/mm.c
> >> -#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
> >> +#define DBG(fmt...) do { if (0) printk(fmt);} while (0)
> > 
> > While there isn't a style guide for one line defines, while you're 
> > adding spaces add one more after the ; before the } where a new line 
> > would normally appear.
> 
> 
> I don't even like the original.  I planned to replace it with the
> following, and will do so now.
> 
> static inline int __attribute__ ((format (printf, 1, 2))) DBG(
> 	const char *fmt, ...) {return 0;}

We have the exact same definition (albeit with a different name, `pr_debug'),
in include/linux/kernel.h...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
