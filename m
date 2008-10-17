Return-Path: <rbrito@ime.usp.br>
Received: from hope.ime.usp.br (hope.ime.usp.br [143.107.45.8])
	by ozlabs.org (Postfix) with SMTP id B0B4EDDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 20:45:00 +1100 (EST)
Date: Fri, 17 Oct 2008 07:38:17 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081017093817.GB26103@ime.usp.br>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081013045116.GA11637@ime.usp.br>
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

This other patch was also sent some days ago and I would appreciate some
feedback on it.


Regards, Rogério Brito.

On Oct 13 2008, Rogério Brito wrote:
> The current defconfig for Linkstation/Kuroboxes has the "Disable Heap
> Randomization" option enabled.
> 
> Since some of these machines are facing the internet, it helps to have
> heap randomization enabled. This patch enables it.
> 
> 
> Signed-off-by: Rogério Brito <rbrito@ime.usp.br>
> 
> ---
> 
> --- linux/arch/powerpc/configs/linkstation_defconfig.old	2008-10-13 00:33:00.000000000 -0300
> +++ linux/arch/powerpc/configs/linkstation_defconfig	2008-10-13 01:11:28.000000000 -0300
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.27-rc4
> -# Thu Aug 21 00:52:05 2008
> +# Linux kernel version: 2.6.27
> +# Mon Oct 13 01:11:21 2008
>  #
>  # CONFIG_PPC64 is not set
>  
> @@ -101,7 +101,7 @@ CONFIG_HOTPLUG=y
>  CONFIG_PRINTK=y
>  CONFIG_BUG=y
>  CONFIG_ELF_CORE=y
> -CONFIG_COMPAT_BRK=y
> +# CONFIG_COMPAT_BRK is not set
>  CONFIG_BASE_FULL=y
>  CONFIG_FUTEX=y
>  CONFIG_ANON_INODES=y
> @@ -1211,7 +1211,6 @@ CONFIG_USB_STORAGE=m
>  # CONFIG_USB_STORAGE_ALAUDA is not set
>  # CONFIG_USB_STORAGE_ONETOUCH is not set
>  # CONFIG_USB_STORAGE_KARMA is not set
> -# CONFIG_USB_STORAGE_SIERRA is not set
>  # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
>  # CONFIG_USB_LIBUSUAL is not set
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
