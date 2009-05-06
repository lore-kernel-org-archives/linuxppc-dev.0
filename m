Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 6F9C250685
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:40:22 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so178798ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 13:40:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-6-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-6-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 14:40:00 -0600
Message-ID: <fa686aa40905061340s212385b1r8be4e2f7505bd0a0@mail.gmail.com>
Subject: Re: [PATCH 05/12] mpc5121ads: Added Reset Module node to DTS.
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
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

Missing patch description.  Otherwise looks okay.

g.

> ---
> =A0arch/powerpc/boot/dts/mpc5121ads.dts | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts=
/mpc5121ads.dts
> index c2b8dbf..1b83a9d 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -166,6 +166,11 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ip=
ic >;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset@e00 { =A0 =A0 // Reset module
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-reset";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xe00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock@f00 { =A0 =A0 // Clock control
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc512=
1-clock";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf00 0x100>;
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
