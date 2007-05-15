Return-Path: <mgreer@mvista.com>
Date: Tue, 15 May 2007 11:15:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: david@gibson.dropbear.id.au
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515181554.GE17643@mag.az.mvista.com>
References: <20070514045404.GP6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514045404.GP6517@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 02:54:04PM +1000, David Gibson wrote:

> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-08 15:07:45.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:38:39.000000000 +1000
> @@ -33,8 +33,8 @@
>  			timebase-frequency = <0>; // Filled in by zImage
>  			i-cache-line-size = <32>;
>  			d-cache-line-size = <32>;
> -			i-cache-size = <0>;
> -			d-cache-size = <0>;
> +			i-cache-size = <2000000>; /* 32 kB */
> +			d-cache-size = <2000000>; /* 32 kB */
>  			dcr-controller;
>  			dcr-access-method = "native";
>  		};

Ahh HA!  You did it too! :)
