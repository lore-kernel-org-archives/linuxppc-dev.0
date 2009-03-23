Return-Path: <mj.embd@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 6F4FCDDEEF
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 17:16:39 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so1555935rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 23:16:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
References: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
	<49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
Date: Mon, 23 Mar 2009 11:46:38 +0530
Message-ID: <62fe9ccc0903222316v6ef19b4akc24a2a72733c7718@mail.gmail.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
From: MJ embd <mj.embd@gmail.com>
To: Li Yang-R58472 <LeoLi@freescale.com>
Content-Type: multipart/alternative; boundary=000e0cd14f6c8a21440465c3359d
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd14f6c8a21440465c3359d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

"fsl,mpc8349-pmc" has .has_deep_sleep = 0, deep_sleeping=0 so the mem
should not do anything and just do a standby.

I am not sure if mem is a valid state in that case under /sys/power/state.

Scott, u can fix it!

-mj


On Mon, Mar 23, 2009 at 11:15 AM, Li Yang-R58472 <LeoLi@freescale.com>wrote:

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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

--000e0cd14f6c8a21440465c3359d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: &#39;Times New Roman=
&#39;; font-size: 14px; border-collapse: collapse; "><pre style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word; ">&quot;fsl,mpc8349-pmc&quot; has .ha=
s_deep_sleep =3D 0, deep_sleeping=3D0 so the mem should not do anything and=
 just do a standby.</pre>
<pre style=3D"white-space: pre-wrap; word-wrap: break-word; ">I am not sure=
 if mem is a valid state in that case under /sys/power/state. </pre><pre st=
yle=3D"white-space: pre-wrap; word-wrap: break-word; ">Scott, u can fix it!=
</pre>
<pre style=3D"white-space: pre-wrap; word-wrap: break-word; ">-mj</pre></sp=
an><br><div class=3D"gmail_quote">On Mon, Mar 23, 2009 at 11:15 AM, Li Yang=
-R58472 <span dir=3D"ltr">&lt;<a href=3D"mailto:LeoLi@freescale.com">LeoLi@=
freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">&gt; -----Original Messag=
e-----<br>
&gt; From: Wood Scott-B07421<br>
</div><div class=3D"im">&gt; Sent: Friday, March 20, 2009 10:42 PM<br>
&gt; To: Li Yang-R58472<br>
&gt; Cc: Soohyung Cho; <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-=
dev@ozlabs.org</a><br>
&gt; Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?<br>
&gt;<br>
</div><div class=3D"im">&gt; Li Yang-R58472 wrote:<br>
&gt; &gt;&gt; However, the code should treat &quot;mem&quot; as &quot;stand=
by&quot; on chips<br>
&gt; that don&#39;t<br>
&gt; &gt;&gt; support deep sleep. =A0What does the device tree<br>
&gt; &gt;<br>
&gt; &gt; Well, shouldn&#39;t the valid() callback reject unsupported<br>
&gt; states instead<br>
&gt; &gt; of covering up?<br>
&gt;<br>
&gt; I don&#39;t think so, in this case. =A0The user is not asking for<br>
&gt; &quot;sleep&quot; or deep sleep&quot;; they are asking for a power sta=
te<br>
&gt; that meets the definition of &quot;standby&quot; (which sleep does) or=
<br>
&gt; which meets the definition of &quot;mem&quot;<br>
&gt; (which both sleep and deep sleep do). =A0When the user asks for<br>
&gt; &quot;mem&quot;, we provide the lowest power mode that qualifies.<br>
<br>
</div>In my understanding, &quot;mem&quot; which is suspend-to-ram means al=
l CPU states and registers are kept in memory and the CPU is completely off=
 during suspension. =A0I don&#39;t think the sleep mode of 8349 qualifies, =
does it?<br>

<br>
- Leo<br>
<div><div></div><div class=3D"h5">_________________________________________=
______<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br>

--000e0cd14f6c8a21440465c3359d--
