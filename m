Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 996D9DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 16:25:34 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so523258pyi.27
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 23:25:34 -0700 (PDT)
Message-ID: <fa686aa40808222325i5edaafc1sb1f0bb04fabbb3e4@mail.gmail.com>
Date: Sat, 23 Aug 2008 00:25:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Huang Weiyi" <weiyi.huang@gmail.com>
Subject: Re: powerpc/mpc5200: remove unused #include <version.h>
In-Reply-To: <20080823131253.1274.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080823131253.1274.WEIYI.HUANG@gmail.com>
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
> The file(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
>  arch/powerpc/sysdev/bestcomm/gen_bd.c
>
> This patch removes the said #include <version.h>.
>
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Thanks, I'll queue this for .28

g.

>
> diff --git a/arch/powerpc/sysdev/bestcomm/gen_bd.c b/arch/powerpc/sysdev/bestcomm/gen_bd.c
> index a3a134c..e0a53e3 100644
> --- a/arch/powerpc/sysdev/bestcomm/gen_bd.c
> +++ b/arch/powerpc/sysdev/bestcomm/gen_bd.c
> @@ -11,7 +11,6 @@
>  *
>  */
>
> -#include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
