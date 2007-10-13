Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 513C4DDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 06:35:27 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1526898wag
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 13:35:27 -0700 (PDT)
Message-ID: <fa686aa40710131335y710cf6edy59a46d365b1d6d67@mail.gmail.com>
Date: Sat, 13 Oct 2007 14:35:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] missing includes in arch/powerpc/platforms/52xx/lite5200.c
In-Reply-To: <20071013184008.GL8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071013184008.GL8181@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/13/07, Al Viro <viro@ftp.linux.org.uk> wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Nak, this patch should be used to fix it instead.  A change to
lite5200 got dropped during merging.

http://patchwork.ozlabs.org/linuxppc/patch?id=14077

Cheers,
g.

> ---
> diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
> index 0caa3d9..774f249 100644
> --- a/arch/powerpc/platforms/52xx/lite5200.c
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -18,6 +18,8 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/of.h>
> +#include <linux/root_dev.h>
> +#include <linux/initrd.h>
>  #include <asm/time.h>
>  #include <asm/io.h>
>  #include <asm/machdep.h>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
