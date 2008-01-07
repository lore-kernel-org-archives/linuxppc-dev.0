Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 3B936DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:31:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1532384anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jan 2008 11:31:36 -0800 (PST)
Message-ID: <fa686aa40801071131u5d1adec8x84b269a14b492202@mail.gmail.com>
Date: Mon, 7 Jan 2008 12:31:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: [RFC PATCH 2/3] Add initial iomega StorCenter board port.
In-Reply-To: <E1JBwBn-0006JC-Nn@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JBwBn-0006JC-Nn@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/7/08, Jon Loeliger <jdl@jdl.com> wrote:
>
> Use cuImage bootwrapper until U-Boot port is completed.
> Derived heavily from Linkstation port.
>
> Signed-off-by: Andy Wilcox <andy@protium.com>
> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> ---
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
> index 8924095..be5cdd2 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig

Curious; why in platforms/embedded6xx vs platforms/82xx?

> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
> index 844947c..f4fb280 100644
> --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -3,5 +3,7 @@
>  #
>  obj-$(CONFIG_MPC7448HPC2)      += mpc7448_hpc2.o
>  obj-$(CONFIG_LINKSTATION)      += linkstation.o ls_uart.o
> +obj-$(CONFIG_STORCENTER)       += storcenter.o
>  obj-$(CONFIG_PPC_HOLLY)                += holly.o
>  obj-$(CONFIG_PPC_PRPMC2800)    += prpmc2800.o
> +obj-$(CONFIG_STORCENTER)       += storcenter.o

Linked twice?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
