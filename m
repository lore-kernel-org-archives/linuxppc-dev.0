Return-Path: <monstr@monstr.eu>
Message-ID: <4C29C386.7090707@monstr.eu>
Date: Tue, 29 Jun 2010 11:57:26 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/5] microblaze: turn CONFIG_OF into a select
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>	<20100629123843.5f94d477.sfr@canb.auug.org.au>
	<20100629124200.20ca24b7.sfr@canb.auug.org.au>
In-Reply-To: <20100629124200.20ca24b7.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> so that we can make CONFIG_OF global and remove it from
> the architecture Kconfig files later.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Michal Simek <monstr@monstr.eu>

> ---
>  arch/microblaze/Kconfig |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 76818f9..2b37820 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -17,6 +17,8 @@ config MICROBLAZE
>  	select HAVE_DMA_ATTRS
>  	select HAVE_DMA_API_DEBUG
>  	select TRACING_SUPPORT
> +	select OF
> +	select OF_FLATTREE
>  
>  config SWAP
>  	def_bool n
> @@ -125,8 +127,7 @@ config CMDLINE_FORCE
>  	  override those passed by the boot loader.
>  
>  config OF
> -	def_bool y
> -	select OF_FLATTREE
> +	bool
>  
>  config PROC_DEVICETREE
>  	bool "Support for device tree in /proc"


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
