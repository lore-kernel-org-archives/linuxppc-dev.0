Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id C0F40DE790
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:00:45 +1000 (EST)
Received: by gxk20 with SMTP id 20so673117gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 14:00:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-8-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-8-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 15:00:23 -0600
Message-ID: <fa686aa40905061400k28928cbarbe7c06dfff79fd7b@mail.gmail.com>
Subject: Re: [PATCH 07/12] mpc5121ads: Clean up and fix NAND description in
	mpc5121ads DTS.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> - Removed unused properties.
> - Corrected NAND flash chip size.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

Looks okay to me.

g.

> ---
> =A0arch/powerpc/boot/dts/mpc5121ads.dts | =A0 13 ++++---------
> =A01 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts=
/mpc5121ads.dts
> index 1b83a9d..93fe12a 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -62,17 +62,12 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ipic >;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0// ADS has two Hynix 512MB Nand flash chip=
s in a single
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 // stacked package .
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // stacked package.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chips =3D <2>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand0@0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "nand0";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x02000=
000>; =A0// first 32 MB of chip 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand1@20000000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "nand1";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x20000000 0x02000=
000>; =A0// first 32 MB of chip 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "nand";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x40000=
000>; =A0// 512MB + 512MB
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};
>
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
