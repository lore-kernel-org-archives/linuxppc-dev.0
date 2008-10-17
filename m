Return-Path: <rbrito@ime.usp.br>
Received: from hope.ime.usp.br (hope.ime.usp.br [143.107.45.8])
	by ozlabs.org (Postfix) with SMTP id 4774CDDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 20:43:58 +1100 (EST)
Date: Fri, 17 Oct 2008 07:37:15 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: compile kernel for linkstations optimized for
	size
Message-ID: <20081017093715.GA26103@ime.usp.br>
References: <20081013040703.GA11059@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081013040703.GA11059@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

It's been some days since I sent the patch below. I would appreciate if any
feedback was given.


Thanks, Rogério Brito.

On Oct 13 2008, Rogério Brito wrote:
> From: Rogério Brito <rbrito@ime.usp.br>
> 
> Since Linkstations and Kuroboxes often have *very* little memory (as
> they are embedded systems), it is desirable to get their kernels
> compiled optimized for size.
> 
> Signed-off-by: Rogério Brito <rbrito@ime.usp.br>
> 
> ---
> 
> I have been using kernels optimized for size on my Kurobox (standard)
> for many different releases and I have experienced no problem with this
> option enabled. Thus, this patch.
> 
> --- linux/arch/powerpc/configs/linkstation_defconfig.old	2008-10-13 00:33:00.000000000 -0300
> +++ linux/arch/powerpc/configs/linkstation_defconfig	2008-10-13 00:38:58.000000000 -0300
> @@ -90,7 +90,7 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_INITRAMFS_SOURCE=""
> -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL=y
>  # CONFIG_EMBEDDED is not set
>  CONFIG_SYSCTL_SYSCALL=y
> 
> 
> -- 
> Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
> http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
> Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
