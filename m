Return-Path: <celius202@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id D8EF8DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 17:17:20 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so877860qwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 23:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
References: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
	<49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
Date: Mon, 23 Mar 2009 15:17:18 +0900
Message-ID: <ffa0ad880903222317p6e675f6q59e59afd8a630ad3@mail.gmail.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
From: Soohyung Cho <celius202@gmail.com>
To: Li Yang-R58472 <LeoLi@freescale.com>, scottwood@freescale.com,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0015175ce0e4eb5d2f0465c33762
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175ce0e4eb5d2f0465c33762
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/3/23 Li Yang-R58472 <LeoLi@freescale.com>

> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, March 20, 2009 10:42 PM
> > To: Li Yang-R58472
> > Cc: Soohyung Cho; linuxppc-dev@ozlabs.org
> > Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
> >
> > Li Yang-R58472 wrote:
> > >> However, the code should treat "mem" as "standby" on chips
> > that don't
> > >> support deep sleep.  What does the device tree
> > >
> > > Well, shouldn't the valid() callback reject unsupported
> > states instead
> > > of covering up?
> >
> > I don't think so, in this case.  The user is not asking for
> > "sleep" or deep sleep"; they are asking for a power state
> > that meets the definition of "standby" (which sleep does) or
> > which meets the definition of "mem"
> > (which both sleep and deep sleep do).  When the user asks for
> > "mem", we provide the lowest power mode that qualifies.
>
> In my understanding, "mem" which is suspend-to-ram means all CPU states and
> registers are kept in memory and the CPU is completely off during
> suspension.  I don't think the sleep mode of 8349 qualifies, does it?
>
> - Leo
>


I also agree to Leo.
It can be confusing, if "mem" means both sleep and deep sleep.
It would be better not to show "mem", if 8349 don't have deep sleep mode.

- Soohyung

--0015175ce0e4eb5d2f0465c33762
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>=A0=A0</div>
<div class=3D"gmail_quote">2009/3/23 Li Yang-R58472 <span dir=3D"ltr">&lt;<=
a href=3D"mailto:LeoLi@freescale.com">LeoLi@freescale.com</a>&gt;</span><br=
>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">&gt; -----Original Message-----<br>&gt; From: Wood Scott-=
B07421<br></div>
<div class=3D"im">&gt; Sent: Friday, March 20, 2009 10:42 PM<br>&gt; To: Li=
 Yang-R58472<br>&gt; Cc: Soohyung Cho; <a href=3D"mailto:linuxppc-dev@ozlab=
s.org">linuxppc-dev@ozlabs.org</a><br>&gt; Subject: Re: suspend-to-mem on t=
he mpc8349e-mitx-gp?<br>
&gt;<br></div>
<div class=3D"im">&gt; Li Yang-R58472 wrote:<br>&gt; &gt;&gt; However, the =
code should treat &quot;mem&quot; as &quot;standby&quot; on chips<br>&gt; t=
hat don&#39;t<br>&gt; &gt;&gt; support deep sleep. =A0What does the device =
tree<br>
&gt; &gt;<br>&gt; &gt; Well, shouldn&#39;t the valid() callback reject unsu=
pported<br>&gt; states instead<br>&gt; &gt; of covering up?<br>&gt;<br>&gt;=
 I don&#39;t think so, in this case. =A0The user is not asking for<br>&gt; =
&quot;sleep&quot; or deep sleep&quot;; they are asking for a power state<br=
>
&gt; that meets the definition of &quot;standby&quot; (which sleep does) or=
<br>&gt; which meets the definition of &quot;mem&quot;<br>&gt; (which both =
sleep and deep sleep do). =A0When the user asks for<br>&gt; &quot;mem&quot;=
, we provide the lowest power mode that qualifies.<br>
<br></div>In my understanding, &quot;mem&quot; which is suspend-to-ram mean=
s all CPU states and registers are kept in memory and the CPU is completely=
 off during suspension. =A0I don&#39;t think the sleep mode of 8349 qualifi=
es, does it?<br>
<br>- Leo<br></blockquote></div>
<div>=A0</div>
<div><br>
<div>I also agree to Leo. </div>
<div>It can be confusing, if &quot;mem&quot; means both sleep and deep slee=
p.</div>
<div>It would be better not to show=A0&quot;mem&quot;, if 8349 don&#39;t ha=
ve deep sleep mode.</div>
<div>=A0</div>
<div>- Soohyung</div></div>

--0015175ce0e4eb5d2f0465c33762--
