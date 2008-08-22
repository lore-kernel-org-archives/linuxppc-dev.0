Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 8DF06DE504
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 19:48:57 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so362952rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:48:56 -0700 (PDT)
Message-ID: <319b0ac50808220248x3e8b7db3s46b88b328aba9c0a@mail.gmail.com>
Date: Fri, 22 Aug 2008 11:48:56 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [machdep_calls] IRQ
In-Reply-To: <1219382445.7861.60.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_32065_24134765.1219398536810"
References: <319b0ac50808210013p677ebb91vf3b30748138c6d4c@mail.gmail.com>
	<1219305767.8008.14.camel@localhost>
	<319b0ac50808210123m81e8364od983d5dbbb601104@mail.gmail.com>
	<1219382445.7861.60.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_32065_24134765.1219398536810
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok thank you, I will begin to implement the irq functions

2008/8/22, Michael Ellerman <michael@ellerman.id.au>:
>
> On Thu, 2008-08-21 at 10:23 +0200, S=E9bastien Chr=E9tien wrote:
> > Exactly, I mean ppc_md.init_IRQ().
>
> > Ok. What have I to setup in this function ? I set the mask and other
> > registers. Is it right ?  How do I chose the mask ?
>
>
> It totally depends on your platform, I really can't tell you. You can
> look at similar platform code if there is some, otherwise the reference
> manual for your hardware or similar should have what you need.
>
>
> > At the end of this funtion, IRQ are disable. Is that right ? So who
> > does enable IRQs ?
>
>
> Yes, irqs get enabled a bit later in start_kernel().
>
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
>

------=_Part_32065_24134765.1219398536810
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok thank you, I will begin to implement the irq functions<br><br><div><span=
 class=3D"gmail_quote">2008/8/22, Michael Ellerman &lt;<a href=3D"mailto:mi=
chael@ellerman.id.au">michael@ellerman.id.au</a>&gt;:</span><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Thu, 2008-08-21 at 10:23 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; E=
xactly, I mean ppc_md.init_IRQ().<br> <br> &gt; Ok. What have I to setup in=
 this function ? I set the mask and other<br> &gt; registers. Is it right ?=
&nbsp;&nbsp;How do I chose the mask ?<br>
 <br> <br>It totally depends on your platform, I really can&#39;t tell you.=
 You can<br> look at similar platform code if there is some, otherwise the =
reference<br> manual for your hardware or similar should have what you need=
.<br>
 <br><br> &gt; At the end of this funtion, IRQ are disable. Is that right ?=
 So who<br> &gt; does enable IRQs ?<br> <br> <br>Yes, irqs get enabled a bi=
t later in start_kernel().<br> <br><br> cheers<br> <br> --<br> Michael Elle=
rman<br>
 OzLabs, IBM Australia Development Lab<br> <br> wwweb: <a href=3D"http://mi=
chael.ellerman.id.au">http://michael.ellerman.id.au</a><br> phone: +61 2 62=
12 1183 (tie line 70 21183)<br> <br> We do not inherit the earth from our a=
ncestors,<br>
 we borrow it from our children. - S.M.A.R.T Person<br> <br></blockquote></=
div><br>

------=_Part_32065_24134765.1219398536810--
