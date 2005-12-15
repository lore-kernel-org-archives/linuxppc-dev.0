Return-Path: <robbinmathew@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id 2B1156888B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 16:50:50 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so224152wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 21:50:49 -0800 (PST)
Message-ID: <5b74ec4d0512142150t217b34e2g6e0c1ef4f4441a6a@mail.gmail.com>
Date: Thu, 15 Dec 2005 11:20:48 +0530
From: Robin Mathew <robbinmathew@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1674_1537482.1134625848978"
Subject: Re: 8260 ethernet driver multicast problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_1674_1537482.1134625848978
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
    I am using 2.4.20 kernel. I have checked up the latest sources in denx.
Think the problem is fixed with the latest sources.
Thanks
Robin

On 12/15/05, linuxppc-embedded-request@ozlabs.org <
linuxppc-embedded-request@ozlabs.org> wrote:
>
>
>    1. Re: 8260 ethernet driver multicast problem (Pantelis Antoniou)
>    2. Re: 8260 ethernet driver multicast problem (Andy Fleming)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 14 Dec 2005 17:20:01 +0200
> From: Pantelis Antoniou <panto@intracom.gr>
> Subject: Re: 8260 ethernet driver multicast problem
> To: Robin Mathew <robbinmathew@gmail.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <43A03821.6040206@intracom.gr>
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> Robin Mathew wrote:
> > Hi,
> > I was encountering a problem with the receipt of multicast packets from
> eth
> > interface in 8260 platform. The issue was traced to the fcc_enet.c
> driver. A
> > stray return in the set_multicast_list function was the culprit.
> >
> > The following is the changes that I have made-
> >
> > Index: fcc_enet.c
> > @@ -1488,7 +1488,6 @@
> >
> >      cep =3D (struct fcc_enet_private *)dev->priv;
> >
> > -return;
> >      /* Get pointer to FCC area in parameter RAM.
> >      */
> >      ep =3D (fcc_enet_t *)dev->base_addr;
> >
> >
> > Can you please tell me whether there is any issue with setting the
> driver in
> > multicast or promiscous mode. Was this change deliberately done or is i=
t
> > really a bug?
> >
> > Thanks in advance,
> > Robin
> >
>
> Robin, what's the kernel version you're using?
>
> If you're using 2.6 there's a brand new driver you can use.
>
> Regards
>
> Pantelis
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 14 Dec 2005 14:13:00 -0600
> From: Andy Fleming <afleming@freescale.com>
> Subject: Re: 8260 ethernet driver multicast problem
> To: Pantelis Antoniou <panto@intracom.gr>
> Cc: Robin Mathew <robbinmathew@gmail.com>,
>         linuxppc-embedded@ozlabs.org
> Message-ID: <2750D02C-4FDE-4267-8B60-E1CECDFF55F4@freescale.com>
> Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; format=3Dflowe=
d
>
>
> On Dec 14, 2005, at 09:20, Pantelis Antoniou wrote:
>
> > Robin Mathew wrote:
> >> Hi,
> >> I was encountering a problem with the receipt of multicast packets
> >> from eth
> >> interface in 8260 platform. The issue was traced to the fcc_enet.c
> >> driver. A
> >> stray return in the set_multicast_list function was the culprit.
> >> The following is the changes that I have made-
> >> Index: fcc_enet.c
> >> @@ -1488,7 +1488,6 @@
> >>      cep =3D (struct fcc_enet_private *)dev->priv;
> >> -return;
> >>      /* Get pointer to FCC area in parameter RAM.
> >>      */
> >>      ep =3D (fcc_enet_t *)dev->base_addr;
> >> Can you please tell me whether there is any issue with setting the
> >> driver in
> >> multicast or promiscous mode. Was this change deliberately done or
> >> is it
> >> really a bug?
> >> Thanks in advance,
> >> Robin
> >
> > Robin, what's the kernel version you're using?
> >
> > If you're using 2.6 there's a brand new driver you can use.
>
>
> Has 8260 platform support been pushed out yet?
>
>
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 16, Issue 37
> *************************************************
>

------=_Part_1674_1537482.1134625848978
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
&nbsp;&nbsp;&nbsp; I am using 2.4.20 kernel. I have checked up the
latest sources in denx. Think the problem is fixed with the latest
sources.<br>
Thanks<br>
Robin<br><br><div><span class=3D"gmail_quote">On 12/15/05, <b class=3D"gmai=
l_sendername"><a href=3D"mailto:linuxppc-embedded-request@ozlabs.org">linux=
ppc-embedded-request@ozlabs.org</a></b> &lt;<a href=3D"mailto:linuxppc-embe=
dded-request@ozlabs.org">
linuxppc-embedded-request@ozlabs.org</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&nbsp;&nbsp; 1. Re: 8260 ether=
net driver multicast problem (Pantelis Antoniou)
<br>&nbsp;&nbsp; 2. Re: 8260 ethernet driver multicast problem (Andy Flemin=
g)<br><br><br>-------------------------------------------------------------=
---------<br><br>Message: 1<br>Date: Wed, 14 Dec 2005 17:20:01 +0200<br>Fro=
m: Pantelis Antoniou &lt;
<a href=3D"mailto:panto@intracom.gr">panto@intracom.gr</a>&gt;<br>Subject: =
Re: 8260 ethernet driver multicast problem<br>To: Robin Mathew &lt;<a href=
=3D"mailto:robbinmathew@gmail.com">robbinmathew@gmail.com</a>&gt;<br>Cc: <a=
 href=3D"mailto:linuxppc-embedded@ozlabs.org">
linuxppc-embedded@ozlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:43A03=
821.6040206@intracom.gr">43A03821.6040206@intracom.gr</a>&gt;<br>Content-Ty=
pe: text/plain; charset=3DISO-8859-1; format=3Dflowed<br><br>Robin Mathew w=
rote:
<br>&gt; Hi,<br>&gt; I was encountering a problem with the receipt of multi=
cast packets from eth<br>&gt; interface in 8260 platform. The issue was tra=
ced to the fcc_enet.c driver. A<br>&gt; stray return in the set_multicast_l=
ist function was the culprit.
<br>&gt;<br>&gt; The following is the changes that I have made-<br>&gt;<br>=
&gt; Index: fcc_enet.c<br>&gt; @@ -1488,7 +1488,6 @@<br>&gt;<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cep =3D (struct fcc_enet_private *)dev-&gt;pri=
v;<br>&gt;<br>&gt; -return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Get pointer to FCC area in param=
eter RAM.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>&gt;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;ep =3D (fcc_enet_t *)dev-&gt;base_addr;<br>&gt;<br>=
&gt;<br>&gt; Can you please tell me whether there is any issue with setting=
 the driver in
<br>&gt; multicast or promiscous mode. Was this change deliberately done or=
 is it<br>&gt; really a bug?<br>&gt;<br>&gt; Thanks in advance,<br>&gt; Rob=
in<br>&gt;<br><br>Robin, what's the kernel version you're using?<br><br>
If you're using 2.6 there's a brand new driver you can use.<br><br>Regards<=
br><br>Pantelis<br><br><br>------------------------------<br><br>Message: 2=
<br>Date: Wed, 14 Dec 2005 14:13:00 -0600<br>From: Andy Fleming &lt;<a href=
=3D"mailto:afleming@freescale.com">
afleming@freescale.com</a>&gt;<br>Subject: Re: 8260 ethernet driver multica=
st problem<br>To: Pantelis Antoniou &lt;<a href=3D"mailto:panto@intracom.gr=
">panto@intracom.gr</a>&gt;<br>Cc: Robin Mathew &lt;<a href=3D"mailto:robbi=
nmathew@gmail.com">
robbinmathew@gmail.com</a>&gt;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;<a href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@o=
zlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:2750D02C-4FDE-4267-8B60-=
E1CECDFF55F4@freescale.com">2750D02C-4FDE-4267-8B60-E1CECDFF55F4@freescale.=
com
</a>&gt;<br>Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; form=
at=3Dflowed<br><br><br>On Dec 14, 2005, at 09:20, Pantelis Antoniou wrote:<=
br><br>&gt; Robin Mathew wrote:<br>&gt;&gt; Hi,<br>&gt;&gt; I was encounter=
ing a problem with the receipt of multicast packets
<br>&gt;&gt; from eth<br>&gt;&gt; interface in 8260 platform. The issue was=
 traced to the fcc_enet.c<br>&gt;&gt; driver. A<br>&gt;&gt; stray return in=
 the set_multicast_list function was the culprit.<br>&gt;&gt; The following=
 is the changes that I have made-
<br>&gt;&gt; Index: fcc_enet.c<br>&gt;&gt; @@ -1488,7 +1488,6 @@<br>&gt;&gt=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cep =3D (struct fcc_enet_private *)dev=
-&gt;priv;<br>&gt;&gt; -return;<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;/* Get pointer to FCC area in parameter RAM.<br>&gt;&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;*/
<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ep =3D (fcc_enet_t *)dev-&g=
t;base_addr;<br>&gt;&gt; Can you please tell me whether there is any issue =
with setting the<br>&gt;&gt; driver in<br>&gt;&gt; multicast or promiscous =
mode. Was this change deliberately done or
<br>&gt;&gt; is it<br>&gt;&gt; really a bug?<br>&gt;&gt; Thanks in advance,=
<br>&gt;&gt; Robin<br>&gt;<br>&gt; Robin, what's the kernel version you're =
using?<br>&gt;<br>&gt; If you're using 2.6 there's a brand new driver you c=
an use.
<br><br><br>Has 8260 platform support been pushed out yet?<br><br><br><br><=
br><br>------------------------------<br><br>______________________________=
_________________<br>Linuxppc-embedded mailing list<br><a href=3D"mailto:Li=
nuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.org/mailman/l=
istinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-emb=
edded</a><br><br>End of Linuxppc-embedded Digest, Vol 16, Issue 37<br>*****=
********************************************
<br></blockquote></div><br>

------=_Part_1674_1537482.1134625848978--
