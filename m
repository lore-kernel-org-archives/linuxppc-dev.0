Return-Path: <afleming@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWpH05fvPzDsF3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 08:13:00 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id b187so7955188wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 15:13:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-4-git-send-email-afleming@gmail.com>
 <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
From: Andy Fleming <afleming@gmail.com>
Date: Sat, 10 Sep 2016 17:12:53 -0500
Message-ID: <CAKWjMd7kKSyg4Ksn8=T9q6308LNBvRH+YqLcAMqqh=-tqEEy7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Cyrus: create a defconfig
To: Scott Wood <scott.wood@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "aperez@alexperez.com" <aperez@alexperez.com>
Content-Type: multipart/alternative; boundary=001a1141d7c09067a5053c2e90ff
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1141d7c09067a5053c2e90ff
Content-Type: text/plain; charset=UTF-8

On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com> wrote:

> On 09/06/2016 02:12 PM, Andy Fleming wrote:
> > This sets up the proper config elements for Power and Reset to work
> > properly (using the gpio pins).
> >
> > Signed-off-by: Andy Fleming <afleming@gmail.com <javascript:;>>
> > ---
> >  arch/powerpc/Makefile                      | 5 +++++
> >  arch/powerpc/configs/cyrus_basic_defconfig | 9 +++++++++
> >  2 files changed, 14 insertions(+)
> >  create mode 100644 arch/powerpc/configs/cyrus_basic_defconfig
>
> Why does cyrus need its own defconfig?  Just enable the power/reset
> stuff in 85xx-hw.config.


>
> Ok.
>

>
> > +CONFIG_EXT3_FS=y
>
> This has nothing to do with power/reset, and is already present in
> fsl-emb-nonhw.config.


> Ok, weird. Are you sure? I see:


> # CONFIG_EXT3_FS is not set
>
> CONFIG_EXT4_FS=y
>
>
>>
>

--001a1141d7c09067a5053c2e90ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, September 6, 2016, Scott Wood &lt;<a href=3D"mailto:sco=
tt.wood@nxp.com">scott.wood@nxp.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On 09/06/2016 02:12 PM, Andy Fleming wrote:<br>
&gt; This sets up the proper config elements for Power and Reset to work<br=
>
&gt; properly (using the gpio pins).<br>
&gt;<br>
&gt; Signed-off-by: Andy Fleming &lt;<a href=3D"javascript:;" onclick=3D"_e=
(event, &#39;cvml&#39;, &#39;afleming@gmail.com&#39;)">afleming@gmail.com</=
a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/powerpc/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 +++++<br>
&gt;=C2=A0 arch/powerpc/configs/cyrus_<wbr>basic_defconfig | 9 +++++++++<br=
>
&gt;=C2=A0 2 files changed, 14 insertions(+)<br>
&gt;=C2=A0 create mode 100644 arch/powerpc/configs/cyrus_<wbr>basic_defconf=
ig<br>
<br>
Why does cyrus need its own defconfig?=C2=A0 Just enable the power/reset<br=
>
stuff in 85xx-hw.config.</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Ok.<br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
&gt; +CONFIG_EXT3_FS=3Dy<br>
<br>
This has nothing to do with power/reset, and is already present in<br>
fsl-emb-nonhw.config.</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Ok, weird. Are you sure? I see:</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"># CONFIG_EXT3_FS is not set</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">CONFIG_EXT4_FS=3Dy</blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><br></blockquote>
<br>
</blockquote>

--001a1141d7c09067a5053c2e90ff--
