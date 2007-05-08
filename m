Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87F09DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 00:36:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l48EapRP010921
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 07:36:51 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l48Eap15002524
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 09:36:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Date: Tue, 8 May 2007 07:36:48 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C012AA475@az33exm24.fsl.freescale.net>
In-Reply-To: <20070508052723.18404.8216.stgit@localhost.localdomain>
References: <20070508052723.18404.8216.stgit@localhost.localdomain>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "Vitaly Bordug" <vitb@kernel.crashing.org>,
	"Samuel Ortiz" <samuel@sortiz.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Adds support of IRDA transceiver residing on PowerQUICC processors and
> enabling such on mpc885ads reference board. The driver is implemented=20
> using of_device concept, hereby implies arch/powerpc support=20
> of the target.
>=20
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts=20
> b/arch/powerpc/boot/dts/mpc885ads.dts
> index 110bf61..95b280c 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -178,6 +178,16 @@
>  				interrupt-parent =3D <930>;
>  				phy-handle =3D <e8002>;
>  			};
> +
> +			scc@a20 {
> +				device_type =3D "network";
> +				compatible =3D "fsl,irda";
> +				model =3D "SCC";
> +				device-id =3D <2>;
> +				reg =3D <a20 18 3d00 80>;
> +				interrupts =3D <1d 3>;
> +				interrupt-parent =3D <930>;
> +			};
>  		};
>  	};
>  };


Any chance we could get an update to the booting-without-of.txt
for any of this?

Thanks,
jdl
