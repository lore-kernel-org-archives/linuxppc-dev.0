Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95F23B6FC9
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:03:23 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
Date: Thu, 16 Feb 2012 05:03:13 +0000
Message-ID: <CAEsOVNcf_1P5Uj2n7Bdb7RjkqT_hSZ2HKiJUZYMrHjcPX0nJ7Q@mail.gmail.com>
References: <14174.1329347321@neuling.org>
 <CAEsOVNcpBLmsmyZLW2HNe3MDR5cx5oJnPMmGD6Mqz4AjG16=9A@mail.gmail.com>
 <16098.1329349063@neuling.org>
 <CAEsOVNfOcH+oaxSqw6Cy1suY_9zVDOhQe+v_e-zTwc0M5Q_Wgg@mail.gmail.com>
 <8058.1329368488@neuling.org>
In-Reply-To: <8058.1329368488@neuling.org>
Content-Type: multipart/alternative;
 boundary="_000_CAEsOVNcf1P5Uj2n7Bdb7RjkqThSZ2HKiJUZYMrHjcPX0nJ7Qmailgm_"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_CAEsOVNcf1P5Uj2n7Bdb7RjkqThSZ2HKiJUZYMrHjcPX0nJ7Qmailgm_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Feb 15, 2012 9:01 PM, "Michael Neuling" <mikey@neuling.org<mailto:mikey@=
neuling.org>> wrote:
>
> In message <CAEsOVNfOcH+oaxSqw6Cy1suY_9zVDOhQe+v_e-zTwc0M5Q_Wgg@mail.gmai=
l.com<mailto:CAEsOVNfOcH%2BoaxSqw6Cy1suY_9zVDOhQe%2Bv_e-zTwc0M5Q_Wgg@mail.g=
mail.com>>
>  you wrote:
> > On Wed, Feb 15, 2012 at 11:37 PM, Michael Neuling <mikey@neuling.org<ma=
ilto:mikey@neuling.org>> wrote:
> > >> > Becky,
> > >> >
> > >> > This has been broken in linux-next for a while. =3D3DA0Looks like =
a merge
> > >> > issue but you were the last to touch it...
> > >> >
> > >> > arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages=
':
> > >> > arch/powerpc/mm/hugetlbpage.c:313: error: passing argument 5 of 'p=
arse=3D
> > _ar=3D3D
> > >> gs' makes integer from pointer without a cast
> > >> > include/linux/moduleparam.h:317: note: expected 's16' but argument=
 is =3D
> > of =3D3D
> > >> type 'int (*)(char *, char *)'
> > >> > arch/powerpc/mm/hugetlbpage.c:313: error: too few arguments to fun=
ctio=3D
> > n '=3D3D
> > >> parse_args'
> > >>
> > >> A suggest fix has been submitted.
> > >
> > > Do you have a link? =3DA0Which tree is it going in?
> >
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2012-February/095903.htm=
l
> >
> > I just sent it. I'm not sure who would pick this up. Ideally it would
> > go in the next release.
>
> I think that's a different problem, as that's already in next.
>
> sfr posted where problem patch is
>

Ah got it. Thanks.

-M

> Mikey
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org<mailto:Linuxppc-dev@lists.ozlabs.org>
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--_000_CAEsOVNcf1P5Uj2n7Bdb7RjkqThSZ2HKiJUZYMrHjcPX0nJ7Qmailgm_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <C4E681E8FCAA8B448FC6DAD64FCE1693@freescale.net>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p><br>
On Feb 15, 2012 9:01 PM, &quot;Michael Neuling&quot; &lt;<a href=3D"mailto:=
mikey@neuling.org">mikey@neuling.org</a>&gt; wrote:<br>
&gt;<br>
&gt; In message &lt;<a href=3D"mailto:CAEsOVNfOcH%2BoaxSqw6Cy1suY_9zVDOhQe%=
2Bv_e-zTwc0M5Q_Wgg@mail.gmail.com">CAEsOVNfOcH&#43;oaxSqw6Cy1suY_9zVDOhQe&#=
43;v_e-zTwc0M5Q_Wgg@mail.gmail.com</a>&gt;<br>
&gt; &nbsp;you wrote:<br>
&gt; &gt; On Wed, Feb 15, 2012 at 11:37 PM, Michael Neuling &lt;<a href=3D"=
mailto:mikey@neuling.org">mikey@neuling.org</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt; &gt; Becky,<br>
&gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; This has been broken in linux-next for a while. =3D=
3DA0Looks like a merge<br>
&gt; &gt; &gt;&gt; &gt; issue but you were the last to touch it...<br>
&gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; arch/powerpc/mm/hugetlbpage.c: In function 'reserve=
_hugetlb_gpages':<br>
&gt; &gt; &gt;&gt; &gt; arch/powerpc/mm/hugetlbpage.c:313: error: passing a=
rgument 5 of 'parse=3D<br>
&gt; &gt; _ar=3D3D<br>
&gt; &gt; &gt;&gt; gs' makes integer from pointer without a cast<br>
&gt; &gt; &gt;&gt; &gt; include/linux/moduleparam.h:317: note: expected 's1=
6' but argument is =3D<br>
&gt; &gt; of =3D3D<br>
&gt; &gt; &gt;&gt; type 'int (*)(char *, char *)'<br>
&gt; &gt; &gt;&gt; &gt; arch/powerpc/mm/hugetlbpage.c:313: error: too few a=
rguments to functio=3D<br>
&gt; &gt; n '=3D3D<br>
&gt; &gt; &gt;&gt; parse_args'<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; A suggest fix has been submitted.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Do you have a link? =3DA0Which tree is it going in?<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://lists.ozlabs.org/pipermail/linuxppc-dev/2012-Fe=
bruary/095903.html">
http://lists.ozlabs.org/pipermail/linuxppc-dev/2012-February/095903.html</a=
><br>
&gt; &gt;<br>
&gt; &gt; I just sent it. I'm not sure who would pick this up. Ideally it w=
ould<br>
&gt; &gt; go in the next release.<br>
&gt;<br>
&gt; I think that's a different problem, as that's already in next.<br>
&gt;<br>
&gt; sfr posted where problem patch is<br>
&gt;</p>
<p>Ah got it. Thanks.</p>
<p>-M</p>
<p>&gt; Mikey<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lis=
ts.ozlabs.org/listinfo/linuxppc-dev</a><br>
</p>
</body>
</html>

--_000_CAEsOVNcf1P5Uj2n7Bdb7RjkqThSZ2HKiJUZYMrHjcPX0nJ7Qmailgm_--
