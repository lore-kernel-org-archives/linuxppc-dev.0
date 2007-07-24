Return-Path: <mokuno@sm.sony.co.jp>
Date: Tue, 24 Jul 2007 11:47:21 +0900
From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH][36/37] Clean up duplicate includes in
	sound/ppc/
In-Reply-To: <200707211704.07263.jesper.juhl@gmail.com>
References: <200707211704.07263.jesper.juhl@gmail.com>
Message-Id: <20070724114325.3254.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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


On Sat, 21 Jul 2007 17:04:07 +0200
Jesper Juhl <jesper.juhl@gmail.com> wrote:

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

Acked-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>

--
Masakazu MOKUNO
