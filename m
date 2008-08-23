Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 27191DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 16:24:39 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so523174pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 23:24:38 -0700 (PDT)
Message-ID: <fa686aa40808222324o162cc41bh9f4568077a73f592@mail.gmail.com>
Date: Sat, 23 Aug 2008 00:24:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Huang Weiyi" <weiyi.huang@gmail.com>
Subject: Re: [POWERPC] XilinxFB: removed unused #include <version.h>
In-Reply-To: <20080823133625.128F.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080823133625.128F.WEIYI.HUANG@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 11:56 PM, Huang Weiyi <weiyi.huang@gmail.com> wrote:
> The driver(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
>  drivers/video/xilinxfb.c
>
> This patch removes the said #include <version.h>.
>
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Thanks, I'll pick this one up for .28

g.

>
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 7b3a842..5da3d24 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -24,7 +24,6 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/version.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
