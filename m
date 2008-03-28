Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 16733DE096
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:44:44 +1100 (EST)
Date: Fri, 28 Mar 2008 19:44:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/3] mpc83xx: fix usb phy_type in mpc837x rdb device trees
Message-ID: <20080328164441.GA7146@localhost.localdomain>
References: <20080328105125.6a072ff7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080328105125.6a072ff7.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 10:51:25AM -0500, Kim Phillips wrote:
> the mpc837x rdb board uses low pin count interfaces (ULPI) to connect
> to the USB PHY.

I've sent this fix two weeks ago...

http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052926.html

> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
>  arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
>  arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 440aa4d..1a7d516 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -151,7 +151,7 @@
>  			#size-cells = <0>;
>  			interrupt-parent = <&ipic>;
>  			interrupts = <38 0x8>;
> -			phy_type = "utmi";
> +			phy_type = "ulpi";
>  		};
>  
>  		mdio@24520 {
> diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> index 9271153..9d259a1 100644
> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> @@ -151,7 +151,7 @@
>  			#size-cells = <0>;
>  			interrupt-parent = <&ipic>;
>  			interrupts = <38 0x8>;
> -			phy_type = "utmi";
> +			phy_type = "ulpi";
>  		};
>  
>  		mdio@24520 {
> diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> index 0dda2fc..8dec2ee 100644
> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> @@ -151,7 +151,7 @@
>  			#size-cells = <0>;
>  			interrupt-parent = <&ipic>;
>  			interrupts = <38 0x8>;
> -			phy_type = "utmi";
> +			phy_type = "ulpi";
>  		};
>  
>  		mdio@24520 {
> -- 
> 1.5.4.4.481.g5075

-- 
Anton Vorontsov
email: cboumailru@gmail.com
irc://irc.freenode.net/bd2
