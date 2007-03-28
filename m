Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C1753DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 04:05:49 +1000 (EST)
Message-ID: <460AAEA5.40008@ru.mvista.com>
Date: Wed, 28 Mar 2007 22:06:29 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: bzolnier@gmail.com
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
References: <200702140101.26639.sshtylyov@ru.mvista.com>
	<200703282147.41696.sshtylyov@ru.mvista.com>
In-Reply-To: <200703282147.41696.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

> Index: linux-2.6/include/linux/ide.h
> ===================================================================
> --- linux-2.6.orig/include/linux/ide.h
> +++ linux-2.6/include/linux/ide.h
> @@ -613,7 +613,6 @@ typedef struct ide_drive_s {
>  
>          u8	quirk_list;	/* considered quirky, set for a specific host */
>          u8	init_speed;	/* transfer rate set at boot */
> -        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
>          u8	current_speed;	/* current transfer rate set */
>          u8	dn;		/* now wide spread use */
>          u8	wcache;		/* status of write cache */

    Oops, forgot to pull the recent kernel before sending out, so this part 
won't apply bacause of the desired_speed nuisance. Do I need to resend?

MBR, Sergei
