Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46A4F1C2.4010704@am.sony.com>
Date: Mon, 23 Jul 2007 11:21:54 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH][36/37] Clean up duplicate includes in sound/ppc/
References: <200707211704.07263.jesper.juhl@gmail.com>
In-Reply-To: <200707211704.07263.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jesper Juhl wrote:
> Hi,
> 
> This patch cleans up duplicate includes in
> 	XXXX/
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
> index 1aa0b46..27b6189 100644
> --- a/sound/ppc/snd_ps3.c
> +++ b/sound/ppc/snd_ps3.c
> @@ -33,7 +33,6 @@
>  #include <linux/dmapool.h>
>  #include <linux/dma-mapping.h>
>  #include <asm/firmware.h>
> -#include <linux/io.h>
>  #include <asm/dma.h>
>  #include <asm/lv1call.h>
>  #include <asm/ps3.h>

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
