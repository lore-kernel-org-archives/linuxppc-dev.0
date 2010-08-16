Return-Path: <crmanik@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id E95DFB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 03:01:06 +1000 (EST)
Received: by eyd9 with SMTP id 9so1441056eyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 Aug 2010 10:01:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mailman.5.1281664801.6486.linuxppc-dev@lists.ozlabs.org>
References: <mailman.5.1281664801.6486.linuxppc-dev@lists.ozlabs.org>
Date: Mon, 16 Aug 2010 10:01:02 -0700
Message-ID: <AANLkTinbTQDQ5odchf_beJuuRf4HhRbi++4vO-cahCpW@mail.gmail.com>
Subject: Re: Linuxppc-dev Digest, Vol 72, Issue 63
From: Manikandan Ramachandran <crmanik@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e649ce460c0c60048df3c75a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e649ce460c0c60048df3c75a
Content-Type: text/plain; charset=ISO-8859-1

> Date: Thu, 12 Aug 2010 13:53:51 -0400
> From: Jeff Angielski <jeff@theptrgroup.com>
> To: linuxppc-dev@lists.ozlabs.org
> Subject: Re: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
> Message-ID: <4C64352F.4090005@theptrgroup.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> On 08/11/2010 06:18 PM, Manikandan Ramachandran wrote:
> > Hello All,
> >      I created a very simple program which has higher priority than
> > normal tasks and runs a tight loop. Under same test environment I ran
> > this program on both non-rt and rt 2.6.33.5 kernel.  To my suprise I see
> > that performance of non-RT kernel is better than RT. non-RT kernel took
> > 3 sec and 366156 usec while RT kernel took about 3 sec and 418011
> > usec.Can someone please explain why the performance of non-rt kernel is
> > better than rt kernel? From the face of the test result, I feel RT has
> > more overhead,Is there any configuration that I could do to bring down
> > the overhead?
>
> Your "surprise" is due to your definition of "performance".
>
> The purpose of the -rt kernels is to reduce the kernel latency.  This is
> important for servicing hardware.  Normal users find the -rt useful for
> audio/video applications.  Engineering and scientific users find the -rt
> beneficially for servicing hardware like sensors or control systems.
>
> If you are just trying to run calculations as fast as you can in user
> space, you'd be better off using the non-rt variants.
>
>
> --
> Jeff Angielski
> The PTR Group
> www.theptrgroup.com
>
>
> Thanks for your response.
>
> On one hand I hear that RT-kernel is meant for reducing kernel latency on
> other hand I see that there is RT-kernel overhead. So what really RT-kernel
> brings to system performance?
>
> Actually I see that latency for higher priority is more or less same for
> non-rt system.
>
> One more thing, since irqs being threaded in RT, and with CFS scheduler in
> 2.6.33, wouldn't we bring down system performance as CFS is O(log(n))  in
> nature?
> --
> Thanks,
> Manik
>

--0016e649ce460c0c60048df3c75a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>
<div class=3D"gmail_quote">
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">Date: Thu, 12 Aug 2010 13:53:51 =
-0400<br>From: Jeff Angielski &lt;<a href=3D"mailto:jeff@theptrgroup.com">j=
eff@theptrgroup.com</a>&gt;<br>
To: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozl=
abs.org</a><br>Subject: Re: Query regarding 2.6.335 RT[Ingo&#39;s] and Non-=
RT performance<br>Message-ID: &lt;<a href=3D"mailto:4C64352F.4090005@theptr=
group.com">4C64352F.4090005@theptrgroup.com</a>&gt;<br>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed<br><br>On 0=
8/11/2010 06:18 PM, Manikandan Ramachandran wrote:<br>&gt; Hello All,<br>&g=
t; =A0 =A0 =A0I created a very simple program which has higher priority tha=
n<br>&gt; normal tasks and runs a tight loop. Under same test environment I=
 ran<br>
&gt; this program on both non-rt and rt 2.6.33.5 kernel. =A0To my suprise I=
 see<br>&gt; that performance of non-RT kernel is better than RT. non-RT ke=
rnel took<br>&gt; 3 sec and 366156 usec while RT kernel took about 3 sec an=
d 418011<br>
&gt; usec.Can someone please explain why the performance of non-rt kernel i=
s<br>&gt; better than rt kernel? From the face of the test result, I feel R=
T has<br>&gt; more overhead,Is there any configuration that I could do to b=
ring down<br>
&gt; the overhead?<br><br>Your &quot;surprise&quot; is due to your definiti=
on of &quot;performance&quot;.<br><br>The purpose of the -rt kernels is to =
reduce the kernel latency. =A0This is<br>important for servicing hardware. =
=A0Normal users find the -rt useful for<br>
audio/video applications. =A0Engineering and scientific users find the -rt<=
br>beneficially for servicing hardware like sensors or control systems.<br>=
<br>If you are just trying to run calculations as fast as you can in user<b=
r>
space, you&#39;d be better off using the non-rt variants.<br><br><br>--<br>=
Jeff Angielski<br>The PTR Group<br><a href=3D"http://www.theptrgroup.com/" =
target=3D"_blank">www.theptrgroup.com</a><br><br><br>
<div>Thanks for your response.</div>
<div>=A0</div>
<div>On one hand I hear that RT-kernel is meant for reducing kernel latency=
 on other hand I see that there is RT-kernel overhead. So what really RT-ke=
rnel brings to system performance?</div>
<div>=A0</div>
<div>Actually I see that latency for higher priority=A0is more or=A0less sa=
me for non-rt system.</div>
<div>=A0</div>
<div>One more thing, since irqs being threaded in RT, and with CFS schedule=
r in 2.6.33, wouldn&#39;t we bring down system performance as CFS is O(log(=
n))=A0 in nature? </div>
<div>-- <br>Thanks,<br>Manik<br></div></blockquote></div>

--0016e649ce460c0c60048df3c75a--
