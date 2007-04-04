Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 7B702DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:36:39 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so750349ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 12:36:37 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 4 Apr 2007 21:33:26 +0200
References: <200702140101.26639.sshtylyov@ru.mvista.com>
	<200703282147.41696.sshtylyov@ru.mvista.com>
	<460AAEA5.40008@ru.mvista.com>
In-Reply-To: <460AAEA5.40008@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200704042133.26985.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > Index: linux-2.6/include/linux/ide.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/ide.h
> > +++ linux-2.6/include/linux/ide.h
> > @@ -613,7 +613,6 @@ typedef struct ide_drive_s {
> >  
> >          u8	quirk_list;	/* considered quirky, set for a specific host */
> >          u8	init_speed;	/* transfer rate set at boot */
> > -        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
> >          u8	current_speed;	/* current transfer rate set */
> >          u8	dn;		/* now wide spread use */
> >          u8	wcache;		/* status of write cache */
> 
>     Oops, forgot to pull the recent kernel before sending out, so this part 
> won't apply bacause of the desired_speed nuisance. Do I need to resend?

I was mentally prepared to fix it manually to save time on both sides but...

Hunk #1 succeeded at 613 with fuzz 2.

;)
