Return-Path: <mohicks@gmail.com>
Received: from mail-qg0-x233.google.com (mail-qg0-x233.google.com
 [IPv6:2607:f8b0:400d:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 190B41A06F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 05:36:08 +1100 (AEDT)
Received: by mail-qg0-f51.google.com with SMTP id i50so8278693qgf.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 10:36:05 -0800 (PST)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <1421098314.4961.109.camel@freescale.com>
References: <20150112152749.GA5450@darwin.bork.org>
 <1421098314.4961.109.camel@freescale.com>
Date: Wed, 14 Jan 2015 13:36:05 -0500
Message-ID: <CAJUS3Xk0DjCvjn4RAPdsAQAuZOUp0SvWoSsxk78YO=cwRtp1PA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: Add empty ranges to etsec2 dts files
From: Martin Hicks <mort@bork.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001a11c1f2e21de578050ca10329
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c1f2e21de578050ca10329
Content-Type: text/plain; charset=UTF-8

Perfect.  I'm glad there's a patch.
mh

On Mon, Jan 12, 2015 at 4:31 PM, Scott Wood <scottwood@freescale.com> wrote:

> On Mon, 2015-01-12 at 10:27 -0500, Martin Hicks wrote:
> >
> > With an earlier change (746c9e9f - Fix PowerPC address parsing hack),
> ethernet
> > has broken on Freescale boards such as the P1022.  All ranges used by the
> > ethernet controllers are also covered by sub-devices that properly
> > declared the used ranges.  The error shown is:
> >
> > fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -12
> >
> > Signed-off-by: Martin Hicks <mort@bork.org>
> > ---
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    1 +
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |    1 +
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |    1 +
> >  3 files changed, 3 insertions(+)
>
> http://patchwork.ozlabs.org/patch/422446/
>
> > diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> > index 1382fec..d1a6c48 100644
> > --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> > @@ -43,6 +43,7 @@ mdio@24000 {
> >  ethernet@b0000 {
> >       #address-cells = <1>;
> >       #size-cells = <1>;
> > +     ranges = <>;
>
> The " = <>" is usually omitted for empty properties.
>
> -Scott
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296

--001a11c1f2e21de578050ca10329
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Perfect.=C2=A0 I&#39;m glad there&#39;s a patch.<div>mh</d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, =
Jan 12, 2015 at 4:31 PM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto=
:scottwood@freescale.com" target=3D"_blank">scottwood@freescale.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Mon, 2=
015-01-12 at 10:27 -0500, Martin Hicks wrote:<br>
&gt;<br>
&gt; With an earlier change (746c9e9f - Fix PowerPC address parsing hack), =
ethernet<br>
&gt; has broken on Freescale boards such as the P1022.=C2=A0 All ranges use=
d by the<br>
&gt; ethernet controllers are also covered by sub-devices that properly<br>
&gt; declared the used ranges.=C2=A0 The error shown is:<br>
&gt;<br>
&gt; fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -1=
2<br>
&gt;<br>
&gt; Signed-off-by: Martin Hicks &lt;<a href=3D"mailto:mort@bork.org">mort@=
bork.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |=C2=A0 =C2=A0 1 +<b=
r>
&gt;=C2=A0 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |=C2=A0 =C2=A0 1 +<b=
r>
&gt;=C2=A0 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |=C2=A0 =C2=A0 1 +<b=
r>
&gt;=C2=A0 3 files changed, 3 insertions(+)<br>
<br>
</span><a href=3D"http://patchwork.ozlabs.org/patch/422446/" target=3D"_bla=
nk">http://patchwork.ozlabs.org/patch/422446/</a><br>
<span class=3D""><br>
&gt; diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerp=
c/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; index 1382fec..d1a6c48 100644<br>
&gt; --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; @@ -43,6 +43,7 @@ mdio@24000 {<br>
&gt;=C2=A0 ethernet@b0000 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ranges =3D &lt;&gt;;<br>
<br>
</span>The &quot; =3D &lt;&gt;&quot; is usually omitted for empty propertie=
s.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></div></div></blockquot=
e></div><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Martin Hicks P.Eng. =C2=A0=C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:mort@bork.org" target=3D"_blank">mor=
t@bork.org</a><br>Bork Consulting Inc. =C2=A0 =C2=A0 | =C2=A0 +1 (613) 266-=
2296<div></div><div></div><div></div></div></div>
</div>

--001a11c1f2e21de578050ca10329--
