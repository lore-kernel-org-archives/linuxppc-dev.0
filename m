Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-bk0-x232.google.com (mail-bk0-x232.google.com
 [IPv6:2a00:1450:4008:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81CC62C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 02:55:00 +1000 (EST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so251384bkb.23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 09:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52139680.1010800@wwwdotorg.org>
References: <cover.1376972170.git.b42378@freescale.com>
 <ede222d17047e863da34a78069ceead2668bd5d2.1376972170.git.b42378@freescale.com>
 <52139680.1010800@wwwdotorg.org>
Date: Wed, 21 Aug 2013 00:54:55 +0800
Message-ID: <CAGoOwPQ_7F1-3AetKBF35pwO_-LNY6yUtx_r8Mn+HZia_WqyoA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v9 2/2] ASoC: fsl: Add S/PDIF machine driver
From: Nicole Otsuka <nicoleotsuka@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Content-Type: multipart/alternative; boundary=20cf30244e0b959ea704e463ea87
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, linuxppc-dev@lists.ozlabs.org,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org,
 p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org,
 festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf30244e0b959ea704e463ea87
Content-Type: text/plain; charset=ISO-8859-1

Hi Stephen,

I have a whole changelist in the cover letter (PATCH 0/2). Please take a
look at it.

And about the codec dummy things.. I do that only because the codec
driver's doc say so.

Thank you,
Nicolin


On Wed, Aug 21, 2013 at 12:17 AM, Stephen Warren <swarren@wwwdotorg.org>wrote:

> On 08/19/2013 10:32 PM, Nicolin Chen wrote:
> > This patch implements a device-tree-only machine driver for Freescale
> > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > fsl_spdif.c drivers.
> >
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> > ---
> >  .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +++++
>
> What changed between v8 and v9?
>
> > diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
>
> > +Optional properties:
> > +
> > +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> > +
> > +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> > +
> > +* Note: At least one of these two properties should be set in the DT
> binding.
>
> I still don't think "dummy CODEC" is an appropriate thing to have in DT.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

--20cf30244e0b959ea704e463ea87
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>I have a whole changelist i=
n the cover letter (PATCH 0/2). Please take a look at it.</div><div><br></d=
iv><div>And about the codec dummy things.. I do that only because the codec=
 driver&#39;s doc say so.</div>
<div><br></div><div>Thank you,</div><div>Nicolin<br><div class=3D"gmail_ext=
ra"><br><br><div class=3D"gmail_quote">On Wed, Aug 21, 2013 at 12:17 AM, St=
ephen Warren <span dir=3D"ltr">&lt;<a href=3D"mailto:swarren@wwwdotorg.org"=
 target=3D"_blank">swarren@wwwdotorg.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 08/19/2013 10:32 PM, Ni=
colin Chen wrote:<br>
&gt; This patch implements a device-tree-only machine driver for Freescale<=
br>
&gt; i.MX series Soc. It works with spdif_transmitter/spdif_receiver and<br=
>
&gt; fsl_spdif.c drivers.<br>
&gt;<br>
&gt; Signed-off-by: Nicolin Chen &lt;<a href=3D"mailto:b42378@freescale.com=
">b42378@freescale.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0.../devicetree/bindings/sound/imx-audio-spdif.txt =A0| =A0 29 +++++=
<br>
<br>
</div>What changed between v8 and v9?<br>
<br>
&gt; diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.t=
xt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt<br>
<div class=3D"im"><br>
&gt; +Optional properties:<br>
&gt; +<br>
&gt; + =A0- spdif-transmitter : The phandle of the spdif-transmitter dummy =
codec<br>
&gt; +<br>
&gt; + =A0- spdif-receiver : The phandle of the spdif-receiver dummy codec<=
br>
&gt; +<br>
&gt; +* Note: At least one of these two properties should be set in the DT =
binding.<br>
<br>
</div>I still don&#39;t think &quot;dummy CODEC&quot; is an appropriate thi=
ng to have in DT.<br>
<div class=3D"HOEnZb"><div class=3D"h5">___________________________________=
____________<br>
Alsa-devel mailing list<br>
<a href=3D"mailto:Alsa-devel@alsa-project.org">Alsa-devel@alsa-project.org<=
/a><br>
<a href=3D"http://mailman.alsa-project.org/mailman/listinfo/alsa-devel" tar=
get=3D"_blank">http://mailman.alsa-project.org/mailman/listinfo/alsa-devel<=
/a><br>
</div></div></blockquote></div><br></div></div></div>

--20cf30244e0b959ea704e463ea87--
