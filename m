Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 288AF1400E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 19:01:48 +1100 (EST)
Received: by mail-wg0-f43.google.com with SMTP id x13so8447518wgg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 01:01:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1396352401.git.Guangyu.Chen@freescale.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
Date: Wed, 2 Apr 2014 16:01:43 +0800
Message-ID: <CAGoOwPQXw82ZgK=ovmBxPifVT-3mC0a0o0GDtZd=AHRfCf3Q_w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/2] Add ipg clock control to sai driver
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Content-Type: multipart/alternative; boundary=089e01228d460184db04f60ab233
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 Li.Xiubo@freescale.com, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, Timur Tabi <timur@tabi.org>,
 broonie@kernel.org, rob@landley.net, galak@codeaurora.org,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e01228d460184db04f60ab233
Content-Type: text/plain; charset=ISO-8859-1

Please disregard this version.

SAI actually has three master clocks and one bus clock.
So the patch should have added three sai_clks to the driver.
I'll later send v2 to append the other two.

Thank you.


On Tue, Apr 1, 2014 at 7:52 PM, Nicolin Chen <Guangyu.Chen@freescale.com>wrote:

> This series of patches add ipg clock control to fsl_sai driver and updates
> the vf610.dtsi accordingly.
>
> @Shawn
> I'm not sure if VF610 currently does full works with SAI audio function.
> The PATCH-2 is based on broonie/for-next.
>
> Nicolin Chen (2):
>   ASoC: fsl_sai: Add clock control for SAI
>   ARM: dts: Add ipg clock for sai2 on VF610 platform
>
>  .../devicetree/bindings/sound/fsl-sai.txt          |  7 ++--
>  arch/arm/boot/dts/vf610.dtsi                       |  4 +--
>  sound/soc/fsl/fsl_sai.c                            | 37
> ++++++++++++++++++++--
>  sound/soc/fsl/fsl_sai.h                            |  2 ++
>  4 files changed, 43 insertions(+), 7 deletions(-)
>
> --
> 1.8.4
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

--089e01228d460184db04f60ab233
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please disregard this version.<div><br></div><div>SAI actu=
ally has three master clocks and one bus clock.<div style>So the patch shou=
ld have added three sai_clks to the driver.</div><div style>I&#39;ll later =
send v2 to append the other two.</div>
<div style><br></div><div style>Thank you.</div></div></div><div class=3D"g=
mail_extra"><br><br><div class=3D"gmail_quote">On Tue, Apr 1, 2014 at 7:52 =
PM, Nicolin Chen <span dir=3D"ltr">&lt;<a href=3D"mailto:Guangyu.Chen@frees=
cale.com" target=3D"_blank">Guangyu.Chen@freescale.com</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This series of patches add ipg clock control=
 to fsl_sai driver and updates<br>
the vf610.dtsi accordingly.<br>
<br>
@Shawn<br>
I&#39;m not sure if VF610 currently does full works with SAI audio function=
.<br>
The PATCH-2 is based on broonie/for-next.<br>
<br>
Nicolin Chen (2):<br>
=A0 ASoC: fsl_sai: Add clock control for SAI<br>
=A0 ARM: dts: Add ipg clock for sai2 on VF610 platform<br>
<br>
=A0.../devicetree/bindings/sound/fsl-sai.txt =A0 =A0 =A0 =A0 =A0| =A07 ++--=
<br>
=A0arch/arm/boot/dts/vf610.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A04 +--<br>
=A0sound/soc/fsl/fsl_sai.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| 37 ++++++++++++++++++++--<br>
=A0sound/soc/fsl/fsl_sai.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A02 ++<br>
=A04 files changed, 43 insertions(+), 7 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.8.4<br>
<br>
<br>
_______________________________________________<br>
Alsa-devel mailing list<br>
<a href=3D"mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org<=
/a><br>
<a href=3D"http://mailman.alsa-project.org/mailman/listinfo/alsa-devel" tar=
get=3D"_blank">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel<=
/a><br>
</font></span></blockquote></div><br></div>

--089e01228d460184db04f60ab233--
