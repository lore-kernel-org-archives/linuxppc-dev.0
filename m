Return-Path: <fchen@apm.com>
Received: from exprod5og116.obsmtp.com (exprod5og116.obsmtp.com [64.18.0.147])
 by ozlabs.org (Postfix) with SMTP id 84F92B70C2
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 12:14:24 +1100 (EST)
Received: by faas1 with SMTP id s1so779164faa.3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 17:14:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1323819246.7671.4.camel@pasglop>
References: <CAEu=RPirE=H1N=KjHNjNRBM6H1fRvrugCw6ojqWaTNm2=WTfng@mail.gmail.com>
 <1323818650.7671.3.camel@pasglop>
 <alpine.LFD.2.02.1112140027230.3020@ionos>
 <1323819246.7671.4.camel@pasglop>
Date: Tue, 13 Dec 2011 17:14:21 -0800
Message-ID: <CAEu=RPgnh-i-SFt4kiiAtDjLZ3A0cAHhk7ch56Uvv0uG_+HfCg@mail.gmail.com>
Subject: Re: CONFIG_NO_HZ added too much idle time in /proc/stat during
 throughput test.
From: Fushen Chen <fchen@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=f46d04426bb871eecf04b4031616
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04426bb871eecf04b4031616
Content-Type: text/plain; charset=ISO-8859-1

This is 2.6.32, but I think 2.6.36 is the same.
Thanks,
Fushen

On Tue, Dec 13, 2011 at 3:34 PM, Benjamin Herrenschmidt <
benh@kernel.crashing.org> wrote:

> On Wed, 2011-12-14 at 00:28 +0100, Thomas Gleixner wrote:
> > On Wed, 14 Dec 2011, Benjamin Herrenschmidt wrote:
> >
> > > On Tue, 2011-12-13 at 12:42 -0800, Fushen Chen wrote:
> > > > On APM82181,  "vmstat" (/proc/stat)  doesn't show correct idle
> > > > percent, if kernel enables "CONFIG_NO_HZ" (Tickless System / Dynamic
> > > > Tick).
> > > >
> > > > When I run wireless throughput test with heavy traffic, "vmstat"
> shows
> > > > very high idle percent while "oprofile" shows very low idle percent.
> > > > During the test, the system is idle, but network traffic uses a lot
> of
> > > > hard IRQ and soft-irq time. "vmstat" would have the correct stats if
> > > > account_idle_ticks(ticks) in kernel/time/tick-sched.c doesn't add
> more
> > > > idle time in "vmstat". In the same test, if I disable "CONFIG_NO_HZ"
> > > > in kernel, idle percent in "vmstat" and "oprofile" would match.
> > > >
> > > > My APM82181 kernel configuration is "CONFIG_NO_HZ",
> "CONFIG_HZ_250=y",
> > > > "CONFIG_HZ=250", and "CONFIG_HIGH_RES_TIMERS".
> > > >
> > > > My question is that if kernel enables "CONFIG_NO_HZ", how would
> kernel
> > > > report correct stats.
> > >
> > > Hi Thomas ! Any idea what we're doing wrong ? :-)
> >
> > Not really, that had been an issue before and had been fixed. Peter ????
>
> Fusen, what kernel version is this ?
>
> Cheers,
> Ben.
>
>
>

--f46d04426bb871eecf04b4031616
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is 2.6.32, but I think 2.6.36 is the same.<br>Thanks,<br>Fushen<br><br=
><div class=3D"gmail_quote">On Tue, Dec 13, 2011 at 3:34 PM, Benjamin Herre=
nschmidt <span dir=3D"ltr">&lt;<a href=3D"mailto:benh@kernel.crashing.org">=
benh@kernel.crashing.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, 2011-12-14 at 00:28 +0100, Thomas Gleixner wrote:<br>
&gt; On Wed, 14 Dec 2011, Benjamin Herrenschmidt wrote:<br>
&gt;<br>
&gt; &gt; On Tue, 2011-12-13 at 12:42 -0800, Fushen Chen wrote:<br>
&gt; &gt; &gt; On APM82181, =A0&quot;vmstat&quot; (/proc/stat) =A0doesn&#39=
;t show correct idle<br>
&gt; &gt; &gt; percent, if kernel enables &quot;CONFIG_NO_HZ&quot; (Tickles=
s System / Dynamic<br>
&gt; &gt; &gt; Tick).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When I run wireless throughput test with heavy traffic, &quo=
t;vmstat&quot; shows<br>
&gt; &gt; &gt; very high idle percent while &quot;oprofile&quot; shows very=
 low idle percent.<br>
&gt; &gt; &gt; During the test, the system is idle, but network traffic use=
s a lot of<br>
&gt; &gt; &gt; hard IRQ and soft-irq time. &quot;vmstat&quot; would have th=
e correct stats if<br>
&gt; &gt; &gt; account_idle_ticks(ticks) in kernel/time/tick-sched.c doesn&=
#39;t add more<br>
&gt; &gt; &gt; idle time in &quot;vmstat&quot;. In the same test, if I disa=
ble &quot;CONFIG_NO_HZ&quot;<br>
&gt; &gt; &gt; in kernel, idle percent in &quot;vmstat&quot; and &quot;opro=
file&quot; would match.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My APM82181 kernel configuration is &quot;CONFIG_NO_HZ&quot;=
, &quot;CONFIG_HZ_250=3Dy&quot;,<br>
&gt; &gt; &gt; &quot;CONFIG_HZ=3D250&quot;, and &quot;CONFIG_HIGH_RES_TIMER=
S&quot;.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My question is that if kernel enables &quot;CONFIG_NO_HZ&quo=
t;, how would kernel<br>
&gt; &gt; &gt; report correct stats.<br>
&gt; &gt;<br>
&gt; &gt; Hi Thomas ! Any idea what we&#39;re doing wrong ? :-)<br>
&gt;<br>
&gt; Not really, that had been an issue before and had been fixed. Peter ??=
??<br>
<br>
</div></div>Fusen, what kernel version is this ?<br>
<br>
Cheers,<br>
Ben.<br>
<br>
<br>
</blockquote></div><br>

--f46d04426bb871eecf04b4031616--
