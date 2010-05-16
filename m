Return-Path: <BATV+0307ec0569c9968e5153+2457+infradead.org+mchehab@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F016FB7DE4
	for <linuxppc-dev@ozlabs.org>; Sun, 16 May 2010 11:54:51 +1000 (EST)
Message-ID: <4BEF5060.5050105@infradead.org>
Date: Sat, 15 May 2010 22:54:40 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
References: <201005051720.22617.PeterHuewe@gmx.de>
	<201005112042.14889.PeterHuewe@gmx.de>
	<20100514060240.GD12002@linux-sh.org>
	<201005141326.52099.PeterHuewe@gmx.de>
In-Reply-To: <201005141326.52099.PeterHuewe@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	David H?rdeman <david@hardeman.nu>, linuxppc-dev@ozlabs.org,
	linux-m68k@lists.linux-m68k.org, linux-next@vger.kernel.org,
	linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Hüwe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch adds a missing include linux/delay.h to prevent
> build failures[1-5]
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> Forwarded to linux-next mailing list - 
> breakage still exists in linux-next of 20100514 - please apply
> 
> KernelVersion: linux-next-20100505

Sorry for not answer earlier. I was traveling. Anyway, this
patch got applied on May, 12:

http://git.kernel.org/?p=linux/kernel/git/mchehab/linux-next.git;a=commitdiff;h=4ace7aa2998b2974948f1948a61a5d348ddae472

> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2571452/
> [2] http://kisskb.ellerman.id.au/kisskb/buildresult/2571188/
> [3] http://kisskb.ellerman.id.au/kisskb/buildresult/2571479/
> [4] http://kisskb.ellerman.id.au/kisskb/buildresult/2571429/
> [5] http://kisskb.ellerman.id.au/kisskb/buildresult/2571432/
> 
> drivers/media/IR/rc-map.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/IR/rc-map.c b/drivers/media/IR/rc-map.c
> index caf6a27..46a8f15 100644
> --- a/drivers/media/IR/rc-map.c
> +++ b/drivers/media/IR/rc-map.c
> @@ -14,6 +14,7 @@
>  
>  #include <media/ir-core.h>
>  #include <linux/spinlock.h>
> +#include <linux/delay.h>
>  
>  /* Used to handle IR raw handler extensions */
>  static LIST_HEAD(rc_map_list);


-- 

Cheers,
Mauro
