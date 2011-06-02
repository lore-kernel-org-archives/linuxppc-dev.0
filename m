Return-Path: <gxt@mprc.pku.edu.cn>
Received: from mprc.pku.edu.cn (mprc.pku.edu.cn [162.105.203.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ED06B6F8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 12:47:21 +1000 (EST)
Subject: Re: [PATCH] Fix build warning of the defconfigs
From: Guan Xuetao <gxt@mprc.pku.edu.cn>
To: Wanlong Gao <wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 17:49:17 +0800
Message-ID: <1307008157.1652.4.camel@epip-laptop>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, sam@ravnborg.org,
	linux@arm.linux.org.uk, manuel.lauss@googlemail.com,
	rientjes@google.com, mingo@elte.hu, vapier@gentoo.org,
	arnd@arndb.de, u.kleine-koenig@pengutronix.de, anton@samba.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	hans-christian.egtvedt@atmel.com
Reply-To: gxt@mprc.pku.edu.cn
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  arch/arm/configs/davinci_all_defconfig     |    2 +-
>  arch/arm/configs/mxs_defconfig             |    2 +-
>  arch/arm/configs/netx_defconfig            |    2 +-
>  arch/arm/configs/viper_defconfig           |    2 +-
>  arch/arm/configs/xcep_defconfig            |    2 +-
>  arch/arm/configs/zeus_defconfig            |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-
>  arch/mips/configs/mtx1_defconfig           |    2 +-
>  arch/powerpc/configs/52xx/pcm030_defconfig |    2 +-
>  arch/powerpc/configs/ps3_defconfig         |    2 +-
>  arch/sh/configs/titan_defconfig            |    2 +-
>  arch/unicore32/configs/debug_defconfig     |    2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/unicore32/configs/debug_defconfig b/arch/unicore32/configs/debug_defconfig
> index b5fbde9..1c367f0 100644
> --- a/arch/unicore32/configs/debug_defconfig
> +++ b/arch/unicore32/configs/debug_defconfig
> @@ -168,7 +168,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  
>  #	Real Time Clock
>  CONFIG_RTC_LIB=m
> -CONFIG_RTC_CLASS=m
> +CONFIG_RTC_CLASS=y
>  
>  ### File systems
>  CONFIG_EXT2_FS=m

I adjust this config option recently, and enable it with y.
So please just drop the modification in unicore32 config file.

Thanks & Regards.

Guan Xuetao
