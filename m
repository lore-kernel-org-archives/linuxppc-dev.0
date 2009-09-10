Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D725B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 01:06:10 +1000 (EST)
Received: from mail-vw0-f177.google.com (mail-vw0-f177.google.com
	[209.85.212.177]) by ozlabs.org (Postfix) with ESMTP id 32BCADDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 01:06:07 +1000 (EST)
Received: by vws7 with SMTP id 7so130959vws.17
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 08:06:06 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1252594539-25202-1-git-send-email-w.sang@pengutronix.de>
References: <1252594539-25202-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Sep 2009 09:05:46 -0600
Message-ID: <fa686aa40909100805y4af7d85an602f501349a180f9@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot/dts: drop obsolete 'fsl5200-clocking'
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 10, 2009 at 8:55 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> The 'fsl5200-clocking'-property was dropped since
> 0d1cde235874b00905bce23f659690d060ebf475. Remove all occurences in dts-fi=
les.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Looks good to me.  I'll pick it up.

g.

> ---
> =A0arch/powerpc/boot/dts/cm5200.dts =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/digsy_mtc.dts =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/lite5200.dts =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/lite5200b.dts =A0| =A0 =A02 --
> =A0arch/powerpc/boot/dts/media5200.dts =A0| =A0 =A02 --
> =A0arch/powerpc/boot/dts/motionpro.dts =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc5121ads.dts | =A0 =A03 ---
> =A0arch/powerpc/boot/dts/pcm030.dts =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/tqm5200.dts =A0 =A0| =A0 =A01 -
> =A010 files changed, 0 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5=
200.dts
> index cee8080..dd38608 100644
> --- a/arch/powerpc/boot/dts/cm5200.dts
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -210,7 +210,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sram@8000 {
> diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/=
digsy_mtc.dts
> index 4c36186..8e9be6b 100644
> --- a/arch/powerpc/boot/dts/digsy_mtc.dts
> +++ b/arch/powerpc/boot/dts/digsy_mtc.dts
> @@ -199,7 +199,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc@50 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "at,24c08";
> diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/l=
ite5200.dts
> index de30b3f..82ff2b1 100644
> --- a/arch/powerpc/boot/dts/lite5200.dts
> +++ b/arch/powerpc/boot/dts/lite5200.dts
> @@ -247,7 +247,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> @@ -256,7 +255,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sram@8000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0-sram";
> diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/=
lite5200b.dts
> index d13cb11..e45a63b 100644
> --- a/arch/powerpc/boot/dts/lite5200b.dts
> +++ b/arch/powerpc/boot/dts/lite5200b.dts
> @@ -251,7 +251,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> @@ -260,7 +259,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sram@8000 {
> diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/=
media5200.dts
> index e297d8b..0c3902b 100644
> --- a/arch/powerpc/boot/dts/media5200.dts
> +++ b/arch/powerpc/boot/dts/media5200.dts
> @@ -223,7 +223,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> @@ -232,7 +231,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sram@8000 {
> diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/=
motionpro.dts
> index 7be8ca0..6ca4fc1 100644
> --- a/arch/powerpc/boot/dts/motionpro.dts
> +++ b/arch/powerpc/boot/dts/motionpro.dts
> @@ -222,7 +222,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc@68 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "dallas,ds1339";
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts=
/mpc5121ads.dts
> index c2b8dbf..c353dac 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -209,7 +209,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1700 0x20>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <9 0x8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ip=
ic >;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@1720 {
> @@ -220,7 +219,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1720 0x20>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <10 0x8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ip=
ic >;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@1740 {
> @@ -231,7 +229,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x1740 0x20>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <11 0x8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ip=
ic >;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2ccontrol@1760 {
> diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm=
030.dts
> index 30bfdc0..8a4ec30 100644
> --- a/arch/powerpc/boot/dts/pcm030.dts
> +++ b/arch/powerpc/boot/dts/pcm030.dts
> @@ -244,7 +244,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> @@ -253,7 +252,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc@51 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "nxp,pcf8563";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0=
x51>;
> diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm=
032.dts
> index 0300426..85d857a 100644
> --- a/arch/powerpc/boot/dts/pcm032.dts
> +++ b/arch/powerpc/boot/dts/pcm032.dts
> @@ -244,7 +244,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> @@ -253,7 +252,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc@51 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "nxp,pcf8563";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0=
x51>;
> diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tq=
m5200.dts
> index c9590b5..1db07f6 100644
> --- a/arch/powerpc/boot/dts/tqm5200.dts
> +++ b/arch/powerpc/boot/dts/tqm5200.dts
> @@ -160,7 +160,6 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc520=
0-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl5200-clocking;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc@68 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible=
 =3D "dallas,ds1307";
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
