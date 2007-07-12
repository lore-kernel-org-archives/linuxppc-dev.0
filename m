Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1184135957.23157.6.camel@localhost.localdomain>
References: <1184135957.23157.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C0041903-5892-4B77-962E-A5877667BBEE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix mpc7448hpc2 tsi108 device_type bug
Date: Thu, 12 Jul 2007 02:39:13 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 11, 2007, at 1:39 AM, Zang Roy-r61911 wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
>
> Fix mpc7448hpc2 tsi108 device_type bug.
> Wrong device type will break the board startup.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Please apply this patch. The bug breaks the board
> startup.
> Please copy patches about 74xx and tsi bridge
> to me.
>
>  arch/powerpc/boot/dts/mpc7448hpc2.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/ 
> boot/dts/mpc7448hpc2.dts
> index 0e3d314..b9158eb 100644
> --- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
> +++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
> @@ -45,7 +45,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		#interrupt-cells = <2>;
> -		device_type = "tsi108-bridge";
> +		device_type = "tsi-bridge";

Is there a reason we don't add:

                 compatible = "tsi108-bridge";

like the holly dts has?

- k

>  		ranges = <00000000 c0000000 00010000>;
>  		reg = <c0000000 00010000>;
>  		bus-frequency = <0>;
> -- 
> 1.5.1
>
>
>
