Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id D4C0EB7E79
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 07:11:10 +1100 (EST)
Received: by ywh14 with SMTP id 14so266891ywh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 12:11:09 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1266433158.2322.1@antares>
References: <1266433158.2322.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Feb 2010 13:10:46 -0700
Message-ID: <fa686aa41002171210y5aed279epe24d51cc8705c13@mail.gmail.com>
Subject: Re: [Patch v2 2/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2010 at 11:59 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Make the I2C adapter timeout configurable through a Device Tree property
> which gives the timeout in microseconds.
>
> Change vs. v.1: use "fsl,timeout" as property name (Thanks, Grant)
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> ---
>
> --- linux-2.6.32-orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> =A02009-12-03 04:51:21.000000000 +0100
> +++ linux-2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt 2010-02-1=
7
> 14:18:01.000000000 +0100
> @@ -21,6 +21,7 @@ Recommended properties :
> =A0- fsl,preserve-clocking : boolean; if defined, the clock settings
> =A0 =A0from the bootloader are preserved (not touched).
> =A0- clock-frequency : desired I2C bus clock frequency in Hz.
> + - fsl,timeout : I2C bus timeout in microseconds.
>
> =A0Examples :
>
> @@ -44,5 +45,6 @@ Examples :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <43 2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <400000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,timeout =3D <10000>;
> =A0 =A0 =A0 =A0};
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
