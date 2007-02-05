Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC930DDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 02:07:40 +1100 (EST)
In-Reply-To: <45C6F472.4090408@freescale.com>
References: <45C6F472.4090408@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C70056A2-0B73-4702-9749-2CC744F89416@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] 8349emds default dts updates for USB change
Date: Mon, 5 Feb 2007 09:06:42 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 3:10 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8349emds.dts |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/ 
> boot/dts/mpc8349emds.dts
> index efceb34..ba31af1 100644
> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> @@ -39,6 +39,11 @@
> 		reg = <00000000 10000000>;	// 256MB at 0
> 	};
> +	bcsr@f8000000 {
> +		device_type = "board-control";
> +		reg = <e2400000 8000>;

Are the bcsr's at f8000000 or e2400000?

> +	};
> +
> 	soc8349@e0000000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> @@ -103,6 +108,7 @@
> 			#size-cells = <0>;
> 			interrupt-parent = <700>;
> 			interrupts = <26 2>;
> +			dr_mode = "otg";

You're introducing a new property without any Documentation  
describing it.

> 			phy_type = "ulpi";
> 		};

- k
