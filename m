Return-Path: <jeclark2006@aim.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79EC91A0C5C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 07:57:11 +1100 (AEDT)
Received: from mwork.nabble.com (mwork.nabble.com [162.253.133.43])
 by ozlabs.org (Postfix) with ESMTP id E3A6814017B
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 07:57:09 +1100 (AEDT)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mwork.nabble.com (Postfix) with ESMTP id 36521108A437
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 12:48:05 -0800 (PST)
Date: Wed, 14 Jan 2015 13:45:13 -0700 (MST)
From: jeclark2006 <jeclark2006@aim.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <2F6E7D9E-CBD1-48C7-A534-1EE5CDB578DA@aim.com>
In-Reply-To: <CAJUS3Xk0DjCvjn4RAPdsAQAuZOUp0SvWoSsxk78YO=cwRtp1PA@mail.gmail.com>
References: <20150112152749.GA5450@darwin.bork.org>
 <1421098314.4961.109.camel@freescale.com>
 <CAJUS3Xk0DjCvjn4RAPdsAQAuZOUp0SvWoSsxk78YO=cwRtp1PA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: Add empty ranges to etsec2 dts files
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_34375_1960048855.1421268313130"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_34375_1960048855.1421268313130
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This was a sort of unfortunate revelation on how things =E2=80=98change=E2=
=80=99.

While as it is, I found this problem, and =E2=80=98fixed=E2=80=99 my device=
 tree source, had this been for units =E2=80=98fielded=E2=80=99, I have to =
sleuth through some amount of kernel
code to find where the OF tree was parsed, and then =E2=80=98fix=E2=80=99 t=
he kernel, as changing the FDT eeprom image is not really a =E2=80=98good=
=E2=80=99 option for
units that are in use, and need a firmware update.

John Clark.


On Jan 14, 2015, at 12:35 PM, Martin Hicks [via linuxppc] <ml-node+s10917n8=
8773h8@n7.nabble.com> wrote:

> Perfect.  I'm glad there's a patch.
> mh
>=20
> On Mon, Jan 12, 2015 at 4:31 PM, Scott Wood <[hidden email]> wrote:
> On Mon, 2015-01-12 at 10:27 -0500, Martin Hicks wrote:
> >
> > With an earlier change (746c9e9f - Fix PowerPC address parsing hack), e=
thernet
> > has broken on Freescale boards such as the P1022.  All ranges used by t=
he
> > ethernet controllers are also covered by sub-devices that properly
> > declared the used ranges.  The error shown is:
> >
> > fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -12
> >
> > Signed-off-by: Martin Hicks <[hidden email]>
> > ---
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    1 +
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |    1 +
> >  arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |    1 +
> >  3 files changed, 3 insertions(+)
>=20
> http://patchwork.ozlabs.org/patch/422446/
>=20
> > diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc=
/boot/dts/fsl/pq3-etsec2-0.dtsi
> > index 1382fec..d1a6c48 100644
> > --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
> > @@ -43,6 +43,7 @@ mdio@24000 {
> >  ethernet@b0000 {
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> > +     ranges =3D <>;
>=20
> The " =3D <>" is usually omitted for empty properties.
>=20
> -Scott
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> [hidden email]
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
>=20
> --=20
> Martin Hicks P.Eng.      |         [hidden email]
> Bork Consulting Inc.     |   +1 (613) 266-2296
>=20
> _______________________________________________=20
> Linuxppc-dev mailing list=20
> [hidden email]=20
> https://lists.ozlabs.org/listinfo/linuxppc-dev=20
>=20
> If you reply to this email, your message will be added to the discussion =
below:
> http://linuxppc.10917.n7.nabble.com/PATCH-powerpc-fsl-Add-empty-ranges-to=
-etsec2-dts-files-tp88699p88773.html
> To start a new topic under linuxppc-dev, email ml-node+s10917n3h38@n7.nab=
ble.com=20
> To unsubscribe from linuxppc, click here.
> NAML





--
View this message in context: http://linuxppc.10917.n7.nabble.com/PATCH-pow=
erpc-fsl-Add-empty-ranges-to-etsec2-dts-files-tp88699p88774.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
------=_Part_34375_1960048855.1421268313130
Content-Type: text/html; charset=UTF8
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"Content-Type" content=3D"text/html charset=3Dwindows-12=
52">This was a sort of unfortunate revelation on how things =E2=80=98change=
=E2=80=99.<div><br></div><div>While as it is, I found this problem, and =E2=
=80=98fixed=E2=80=99 my device tree source, had this been for units =E2=80=
=98fielded=E2=80=99, I have to sleuth through some amount of kernel</div><d=
iv>code to find where the OF tree was parsed, and then =E2=80=98fix=E2=80=
=99 the kernel, as changing the FDT eeprom image is not really a =E2=80=98g=
ood=E2=80=99 option for</div><div>units that are in use, and need a firmwar=
e update.</div><div><br></div><div>John Clark.</div><div><br></div><div><br=
><div><div>On Jan 14, 2015, at 12:35 PM, Martin Hicks [via linuxppc] &lt;<a=
 href=3D"/user/SendEmail.jtp?type=3Dnode&node=3D88774&i=3D0" target=3D"_top=
" rel=3D"nofollow" link=3D"external">[hidden email]</a>&gt; wrote:</div><br=
 class=3D"Apple-interchange-newline"><blockquote style=3D'border-left:2px s=
olid #CCCCCC;padding:0 1em' type=3D"cite">

=09<div dir=3D"ltr">Perfect.&nbsp; I'm glad there's a patch.<div>mh</div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jan 1=
2, 2015 at 4:31 PM, Scott Wood <span dir=3D"ltr">&lt;&lt;a href=3D&quot;x-m=
sg://35/user/SendEmail.jtp?type=3Dnode&amp;amp;node=3D88773&amp;amp;i=3D0&q=
uot; target=3D&quot;_top&quot; rel=3D&quot;nofollow&quot; link=3D&quot;exte=
rnal&quot;&gt;[hidden email]</a>&gt;</span> wrote:<br><blockquote style=3D'=
border-left:2px solid #CCCCCC;padding:0 1em' style=3D"border-left:2px solid=
 #CCCCCC;padding:0 1em" class=3D"gmail_quote"><span class=3D"">On Mon, 2015=
-01-12 at 10:27 -0500, Martin Hicks wrote:<br>
&gt;<br>
&gt; With an earlier change (746c9e9f - Fix PowerPC address parsing hack), =
ethernet<br>
&gt; has broken on Freescale boards such as the P1022.&nbsp; All ranges use=
d by the<br>
&gt; ethernet controllers are also covered by sub-devices that properly<br>
&gt; declared the used ranges.&nbsp; The error shown is:<br>
&gt;<br>
&gt; fsl-gianfar: probe of soc@ffe00000:ethernet@b0000 failed with error -1=
2<br>
&gt;<br>
&gt; Signed-off-by: Martin Hicks &lt;&lt;a href=3D&quot;x-msg://35/user/Sen=
dEmail.jtp?type=3Dnode&amp;amp;node=3D88773&amp;amp;i=3D1&quot; target=3D&q=
uot;_top&quot; rel=3D&quot;nofollow&quot; link=3D&quot;external&quot;&gt;[h=
idden email]</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |&nbsp; &nbsp; 1 +<b=
r>
&gt;&nbsp; arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi |&nbsp; &nbsp; 1 +<b=
r>
&gt;&nbsp; arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi |&nbsp; &nbsp; 1 +<b=
r>
&gt;&nbsp; 3 files changed, 3 insertions(+)<br>
<br>
</span><a href=3D"http://patchwork.ozlabs.org/patch/422446/" target=3D"_bla=
nk" rel=3D"nofollow" link=3D"external">http://patchwork.ozlabs.org/patch/42=
2446/</a><br>
<span class=3D""><br>
&gt; diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerp=
c/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; index 1382fec..d1a6c48 100644<br>
&gt; --- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; +++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi<br>
&gt; @@ -43,6 +43,7 @@ mdio@24000 {<br>
&gt;&nbsp; ethernet@b0000 {<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;#address-cells =3D &lt;1&gt;;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;#size-cells =3D &lt;1&gt;;<br>
&gt; +&nbsp; &nbsp; &nbsp;ranges =3D &lt;&gt;;<br>
<br>
</span>The " =3D &lt;&gt;" is usually omitted for empty properties.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
&lt;a href=3D&quot;x-msg://35/user/SendEmail.jtp?type=3Dnode&amp;amp;node=
=3D88773&amp;amp;i=3D2&quot; target=3D&quot;_top&quot; rel=3D&quot;nofollow=
&quot; link=3D&quot;external&quot;&gt;[hidden email]</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
" rel=3D"nofollow" link=3D"external">https://lists.ozlabs.org/listinfo/linu=
xppc-dev</a></div></div></blockquote></div><br><br clear=3D"all"><div><br><=
/div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Martin Hicks P.=
Eng. &nbsp;&nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &lt;a href=3D&quot;x=
-msg://35/user/SendEmail.jtp?type=3Dnode&amp;amp;node=3D88773&amp;amp;i=3D3=
&quot; target=3D&quot;_top&quot; rel=3D&quot;nofollow&quot; link=3D&quot;ex=
ternal&quot;&gt;[hidden email]</a><br>Bork Consulting Inc. &nbsp; &nbsp; | =
&nbsp; +1 (613) 266-2296<div></div><div></div><div></div></div></div>
</div>
<br>_______________________________________________
<br>Linuxppc-dev mailing list
<br>&lt;a href=3D&quot;x-msg://35/user/SendEmail.jtp?type=3Dnode&amp;amp;no=
de=3D88773&amp;amp;i=3D4&quot; target=3D&quot;_top&quot; rel=3D&quot;nofoll=
ow&quot; link=3D&quot;external&quot;&gt;[hidden email]</a>
<br><a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_t=
op" rel=3D"nofollow" link=3D"external">https://lists.ozlabs.org/listinfo/li=
nuxppc-dev</a>

=09
=09
=09
=09<br>
=09<br>
=09<hr noshade=3D"noshade" size=3D"1">
=09<div style=3D"color:#444; font: 12px tahoma,geneva,helvetica,arial,sans-=
serif;">
=09=09<div style=3D"font-weight:bold">If you reply to this email, your mess=
age will be added to the discussion below:</div>
=09=09<a href=3D"http://linuxppc.10917.n7.nabble.com/PATCH-powerpc-fsl-Add-=
empty-ranges-to-etsec2-dts-files-tp88699p88773.html" target=3D"_top" rel=3D=
"nofollow" link=3D"external">http://linuxppc.10917.n7.nabble.com/PATCH-powe=
rpc-fsl-Add-empty-ranges-to-etsec2-dts-files-tp88699p88773.html</a>
=09</div>
=09<div style=3D"color:#666; font: 11px tahoma,geneva,helvetica,arial,sans-=
serif;margin-top:.4em;line-height:1.5em">
=09=09To start a new topic under linuxppc-dev, email <a href=3D"/user/SendE=
mail.jtp?type=3Dnode&node=3D88774&i=3D1" target=3D"_top" rel=3D"nofollow" l=
ink=3D"external">[hidden email]</a> <br>
=09=09To unsubscribe from linuxppc, <a href=3D"" target=3D"_top" rel=3D"nof=
ollow" link=3D"external">click here</a>.<br>
=09=09<a href=3D"http://linuxppc.10917.n7.nabble.com/template/NamlServlet.j=
tp?macro=3Dmacro_viewer&amp;id=3Dinstant_html%21nabble%3Aemail.naml&amp;bas=
e=3Dnabble.naml.namespaces.BasicNamespace-nabble.view.web.template.NabbleNa=
mespace-nabble.view.web.template.NodeNamespace&amp;breadcrumbs=3Dnotify_sub=
scribers%21nabble%3Aemail.naml-instant_emails%21nabble%3Aemail.naml-send_in=
stant_email%21nabble%3Aemail.naml" rel=3D"nofollow" style=3D"font:9px serif=
" target=3D"_top" link=3D"external">NAML</a>
=09</div></blockquote></div><br></div>

=09
=09
=09
<br/><hr align=3D"left" width=3D"300" />
View this message in context: <a href=3D"http://linuxppc.10917.n7.nabble.co=
m/PATCH-powerpc-fsl-Add-empty-ranges-to-etsec2-dts-files-tp88699p88774.html=
">Re: [PATCH] powerpc/fsl: Add empty ranges to etsec2 dts files</a><br/>
Sent from the <a href=3D"http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f=
3.html">linuxppc-dev mailing list archive</a> at Nabble.com.<br/>
------=_Part_34375_1960048855.1421268313130--
