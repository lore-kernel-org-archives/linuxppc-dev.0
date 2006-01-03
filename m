Return-Path: <gnathita@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id B159C689A1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 19:29:40 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so2133985wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jan 2006 00:29:38 -0800 (PST)
Message-ID: <259581790601030029j6fa915f9nfb3869ad41915aa4@mail.gmail.com>
Date: Tue, 3 Jan 2006 09:29:38 +0100
From: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <43BA34C5.9050609@secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16209_33288424.1136276978067"
References: <259581790601030012u1ec195c2n7f42766d443548c2@mail.gmail.com>
	<43BA34C5.9050609@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 8/8] Add support for Xilinx ML403 reference design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_16209_33288424.1136276978067
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Grant,

I=B4ll try the patches today and I let you know how is going.

See you!

On 1/3/06, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> Paula Saame=F1o wrote:
> > I am working with ML403 as well. Right now, I am using a 2.4.26 kernel,
> > but I would be interested in a 2.6 one, it would be great!!
> >
> > Happy 2006!!
> > Paula Saameno
>
> Thanks Paula.
>
> Can you try the posted patches on your ML403?  It should compile and
> boot with no problems with the reference design.  (However, I got the
> memory size initialization wrong; add mem=3D64M to the kernel command lin=
e)
>
> I'll send a patch to fix the mem size tomorrow.
>
> Thanks,
> g.
>
> >
> > Florian wrote:
> >>> I don't have a public git tree at the moment for the xilinx virtex
> >>> stuff.  I can certainly create and maintain one if there is demand.  =
I
> >>> guess it depends on how many people want to colaborate on V2Pro/V4
> >>> support.  Anyone else interested?
> >>
> >>
> >> Yes. I am also working on a Virtex-4 system with Linux.
> >> Do you support also a Linux 2.4 tree?
> > Sorry, no.  I'm focusing on the 2.6 stuff.  IIRC, the Denx tree is
> > tracking the virtex support in 2.4.
> >
> > Are you strictly working on 2.4?  Or are you interested in 2.6 as well?
> >
> > Cheers,
> > g.
> >
> >
> > -----------------------------------------------------------------------=
-
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> (403) 663-0761
>

------=_Part_16209_33288424.1136276978067
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Grant,<br>
<br>
I=B4ll try the patches today and I let you know how is going.<br>
<br>
See you!<br><br><div><span class=3D"gmail_quote">On 1/3/06, <b class=3D"gma=
il_sendername">Grant Likely</b> &lt;<a href=3D"mailto:grant.likely@secretla=
b.ca">grant.likely@secretlab.ca</a>&gt; wrote:</span><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
Paula Saame=F1o wrote:<br>&gt; I am working with ML403 as well. Right now, =
I am using a 2.4.26 kernel,<br>&gt; but I would be interested in a 2.6 one,=
 it would be great!!<br>&gt;<br>&gt; Happy 2006!!<br>&gt; Paula Saameno<br>
<br>Thanks Paula.<br><br>Can you try the posted patches on your ML403?&nbsp=
;&nbsp;It should compile and<br>boot with no problems with the reference de=
sign.&nbsp;&nbsp;(However, I got the<br>memory size initialization wrong; a=
dd mem=3D64M to the kernel command line)
<br><br>I'll send a patch to fix the mem size tomorrow.<br><br>Thanks,<br>g=
.<br><br>&gt;<br>&gt; Florian wrote:<br>&gt;&gt;&gt; I don't have a public =
git tree at the moment for the xilinx virtex<br>&gt;&gt;&gt; stuff.&nbsp;&n=
bsp;I can certainly create and maintain one if there is demand.&nbsp;&nbsp;=
I
<br>&gt;&gt;&gt; guess it depends on how many people want to colaborate on =
V2Pro/V4<br>&gt;&gt;&gt; support.&nbsp;&nbsp;Anyone else interested?<br>&gt=
;&gt;<br>&gt;&gt;<br>&gt;&gt; Yes. I am also working on a Virtex-4 system w=
ith Linux.
<br>&gt;&gt; Do you support also a Linux 2.4 tree?<br>&gt; Sorry, no.&nbsp;=
&nbsp;I'm focusing on the 2.6 stuff.&nbsp;&nbsp;IIRC, the Denx tree is<br>&=
gt; tracking the virtex support in 2.4.<br>&gt;<br>&gt; Are you strictly wo=
rking on 2.4?&nbsp;&nbsp;Or are you interested in=20
2.6 as well?<br>&gt;<br>&gt; Cheers,<br>&gt; g.<br>&gt;<br>&gt;<br>&gt; ---=
---------------------------------------------------------------------<br>&g=
t;<br>&gt; _______________________________________________<br>&gt; Linuxppc=
-embedded mailing list
<br>&gt; <a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@=
ozlabs.org</a><br>&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linux=
ppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
<br><br>--<br>Grant Likely, B.Sc. P.Eng.<br>Secret Lab Technologies Ltd.<br=
>(403) 663-0761<br></blockquote></div><br>

------=_Part_16209_33288424.1136276978067--
