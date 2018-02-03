Return-Path: <madskateman@gmail.com>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com
 [IPv6:2607:f8b0:400d:c0d::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYXMS2rlczDrHh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 22:54:28 +1100 (AEDT)
Received: by mail-qt0-x22d.google.com with SMTP id m11so6680722qtn.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Feb 2018 03:54:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com> <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com> <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
From: mad skateman <madskateman@gmail.com>
Date: Sat, 3 Feb 2018 12:54:23 +0100
Message-ID: <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Content-Type: multipart/alternative; boundary="001a11482d107ce3d805644d7d06"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11482d107ce3d805644d7d06
Content-Type: text/plain; charset="UTF-8"

For those interested... i have recorded a video of my X5000 DPAA Ethernet,
and the weird problems..
In this Video i am also transfering hundereds of megabytes from my NAS to
the X5000.
You will also see pings die... mostly after the 12th packet and giving the
no buffer space error..
Hopefully someone might have a clue about what is happening.

https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view

On Wed, Jan 17, 2018 at 3:43 PM, Madalin-cristian Bucur <
madalin.bucur@nxp.com> wrote:

> > -----Original Message-----
> > From: Madalin-cristian Bucur
> > Sent: Wednesday, January 17, 2018 4:25 PM
> > To: David S . Miller <davem@davemloft.net>
> > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
> > madskateman@gmail.com; 'Madalin-cristian Bucur' <madalin.bucur@nxp.com>;
> > Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com>
> > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
> >
> > > -----Original Message-----
> > > From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.
> kernel.org]
> > > On Behalf Of Madalin-cristian Bucur
> > > Sent: Wednesday, January 17, 2018 4:16 PM
> > > To: Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
> > > <Joakim.Tjernlund@infinera.com>
> > > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
> > > madskateman@gmail.com; David S . Miller <davem@davemloft.net>
> > > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
> > >
> > > > -----Original Message-----
> > > > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > > > Sent: Wednesday, January 17, 2018 3:44 PM
> > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
> > > >
> > > > > That doesn't work really, having users to hit the bug, debug it,
> fix
> > > it
> > > > and then
> > > > > find it fixed already in upstream, then specifically request it to
> > be
> > > > backported to stable.
> > > > > I don't need this fix to be backported, already got it. Someone
> else
> > > > might though.
> > > >
> > > > The "someone else might though" is a big point of asking for it to
> > > > added to stable. The other reason is it means one less patch you need
> > > > to maintain in your build.
> > >
> > > I've sent that patch [1] for net but I guess the timing was wrong and
> > > it was merged to net-next.
> > >
> > > > > I would be interested in bug fixes upstream which fixes:
> > > >
> > > > Did you try upstream? Does it give the same errors?
> > > >
> > > >     Andrew
> > >
> > > [1] https://patchwork.kernel.org/patch/10146119/
> > >
> > > Madalin
> >
> > Hi Dave,
> >
> > Can you please add the fix [1] to stable?
> >
> > Thank you,
> > Madalin
>
> Sorry,
>
> I've provided the wrong link towards the patch (v1 instead of v3),
> here's the correct one:
>
> https://patchwork.kernel.org/patch/10151969/
>
> Madalin
>

--001a11482d107ce3d805644d7d06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><br></div><div>For those interested... i have re=
corded a video of my X5000 DPAA Ethernet, and the weird problems..</div><di=
v>In this Video i am also transfering hundereds of megabytes from my NAS to=
 the X5000.</div><div>You will also see pings die... mostly after the 12th =
packet and giving the no buffer space error..</div></div><div>Hopefully som=
eone might have a clue about what is happening.</div><div><br></div><a href=
=3D"https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view"=
>https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view</a>=
<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed,=
 Jan 17, 2018 at 3:43 PM, Madalin-cristian Bucur <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:madalin.bucur@nxp.com" target=3D"_blank">madalin.bucur@nxp.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; -----Origina=
l Message-----<br>
&gt; From: Madalin-cristian Bucur<br>
&gt; Sent: Wednesday, January 17, 2018 4:25 PM<br>
&gt; To: David S . Miller &lt;<a href=3D"mailto:davem@davemloft.net">davem@=
davemloft.net</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@list=
s.ozlabs.org</a>; <a href=3D"mailto:netdev@vger.kernel.org">netdev@vger.ker=
nel.org</a>;<br>
&gt; <a href=3D"mailto:madskateman@gmail.com">madskateman@gmail.com</a>; &#=
39;Madalin-cristian Bucur&#39; &lt;<a href=3D"mailto:madalin.bucur@nxp.com"=
>madalin.bucur@nxp.com</a>&gt;;<br>
&gt; Andrew Lunn &lt;<a href=3D"mailto:andrew@lunn.ch">andrew@lunn.ch</a>&g=
t;; Joakim Tjernlund<br>
&gt; &lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com">Joakim.Tjernlund@=
infinera.com</a><wbr>&gt;<br>
&gt; Subject: RE: DPAA Ethernet traffice troubles with Linux kernel<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: <a href=3D"mailto:netdev-owner@vger.kernel.org">netdev-owne=
r@vger.kernel.org</a> [mailto:<a href=3D"mailto:netdev-owner@vger.kernel.or=
g">netdev-owner@vger.<wbr>kernel.org</a>]<br>
&gt; &gt; On Behalf Of Madalin-cristian Bucur<br>
&gt; &gt; Sent: Wednesday, January 17, 2018 4:16 PM<br>
&gt; &gt; To: Andrew Lunn &lt;<a href=3D"mailto:andrew@lunn.ch">andrew@lunn=
.ch</a>&gt;; Joakim Tjernlund<br>
&gt; &gt; &lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com">Joakim.Tjern=
lund@infinera.com</a><wbr>&gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev=
@lists.ozlabs.org</a>; <a href=3D"mailto:netdev@vger.kernel.org">netdev@vge=
r.kernel.org</a>;<br>
&gt; &gt; <a href=3D"mailto:madskateman@gmail.com">madskateman@gmail.com</a=
>; David S . Miller &lt;<a href=3D"mailto:davem@davemloft.net">davem@daveml=
oft.net</a>&gt;<br>
&gt; &gt; Subject: RE: DPAA Ethernet traffice troubles with Linux kernel<br=
>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Andrew Lunn [mailto:<a href=3D"mailto:andrew@lunn.ch">=
andrew@lunn.ch</a>]<br>
&gt; &gt; &gt; Sent: Wednesday, January 17, 2018 3:44 PM<br>
&gt; &gt; &gt; To: Joakim Tjernlund &lt;<a href=3D"mailto:Joakim.Tjernlund@=
infinera.com">Joakim.Tjernlund@infinera.com</a><wbr>&gt;<br>
&gt; &gt; &gt; Subject: Re: DPAA Ethernet traffice troubles with Linux kern=
el<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; That doesn&#39;t work really, having users to hit the b=
ug, debug it, fix<br>
&gt; &gt; it<br>
&gt; &gt; &gt; and then<br>
&gt; &gt; &gt; &gt; find it fixed already in upstream, then specifically re=
quest it to<br>
&gt; be<br>
&gt; &gt; &gt; backported to stable.<br>
&gt; &gt; &gt; &gt; I don&#39;t need this fix to be backported, already got=
 it. Someone else<br>
&gt; &gt; &gt; might though.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The &quot;someone else might though&quot; is a big point of =
asking for it to<br>
&gt; &gt; &gt; added to stable. The other reason is it means one less patch=
 you need<br>
&gt; &gt; &gt; to maintain in your build.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;ve sent that patch [1] for net but I guess the timing was w=
rong and<br>
&gt; &gt; it was merged to net-next.<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; I would be interested in bug fixes upstream which fixes=
:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Did you try upstream? Does it give the same errors?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0Andrew<br>
&gt; &gt;<br>
&gt; &gt; [1] <a href=3D"https://patchwork.kernel.org/patch/10146119/" rel=
=3D"noreferrer" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1=
0146119/</a><br>
&gt; &gt;<br>
&gt; &gt; Madalin<br>
&gt;<br>
&gt; Hi Dave,<br>
&gt;<br>
&gt; Can you please add the fix [1] to stable?<br>
&gt;<br>
&gt; Thank you,<br>
&gt; Madalin<br>
<br>
Sorry,<br>
<br>
I&#39;ve provided the wrong link towards the patch (v1 instead of v3),<br>
here&#39;s the correct one:<br>
<br>
<a href=3D"https://patchwork.kernel.org/patch/10151969/" rel=3D"noreferrer"=
 target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/10151969/</a><br=
>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Madalin<br>
</font></span></blockquote></div><br></div>

--001a11482d107ce3d805644d7d06--
