Return-Path: <adobriyan@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id F125BDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 00:45:16 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so938342eyi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Nov 2008 05:45:14 -0800 (PST)
Date: Mon, 3 Nov 2008 16:48:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ps3: ps3-lpm.c compile fix
Message-ID: <20081103134829.GA3432@x200.localdomain>
References: <20081102172650.GA7219@x200.localdomain>
	<Pine.LNX.4.64.0811030920170.11062@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0811030920170.11062@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 03, 2008 at 09:20:28AM +0100, Geert Uytterhoeven wrote:
> On Sun, 2 Nov 2008, Alexey Dobriyan wrote:
> > drivers/ps3/ps3-lpm.c:838: error: implicit declaration of function 'get_hard_smp_processor_id'
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  drivers/ps3/ps3-lpm.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- a/drivers/ps3/ps3-lpm.c
> > +++ b/drivers/ps3/ps3-lpm.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/uaccess.h>
> > +#include <asm/smp.h>
> 
> #include <linux/smp.h>?

Nope, everybody else uses asm/smp.h.
