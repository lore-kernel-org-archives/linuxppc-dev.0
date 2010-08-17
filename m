Return-Path: <crmanik@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 796FAB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 15:26:18 +1000 (EST)
Received: by wwc33 with SMTP id 33so4146173wwc.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 Aug 2010 22:26:15 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 16 Aug 2010 22:26:15 -0700
Message-ID: <AANLkTinFe2ruNJVsAaxN_sei3U1D5pOx8-fTH5e4xx+e@mail.gmail.com>
Subject: Re: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
From: Manikandan Ramachandran <crmanik@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> ------------------------------------------------------
> > Date: Thu, 12 Aug 2010 13:53:51 -0400
> > From: Jeff Angielski <jeff@theptrgroup.com>
> > To: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: Query regarding 2.6.335 RT[Ingo's] and Non-RT performance
> > Message-ID: <4C64352F.4090005@theptrgroup.com>
> > Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
> >
> > On 08/11/2010 06:18 PM, Manikandan Ramachandran wrote:
> > > Hello All,
> > > =A0 =A0 =A0I created a very simple program which has higher priority =
than
> > > normal tasks and runs a tight loop. Under same test environment I ran
> > > this program on both non-rt and rt 2.6.33.5 kernel. =A0To my suprise =
I see
> > > that performance of non-RT kernel is better than RT. non-RT kernel to=
ok
> > > 3 sec and 366156 usec while RT kernel took about 3 sec and 418011
> > > usec.Can someone please explain why the performance of non-rt kernel =
is
> > > better than rt kernel? From the face of the test result, I feel RT ha=
s
> > > more overhead,Is there any configuration that I could do to bring dow=
n
> > > the overhead?
> >
> > Your "surprise" is due to your definition of "performance".
> >
> > The purpose of the -rt kernels is to reduce the kernel latency. =A0This=
 is
> > important for servicing hardware. =A0Normal users find the -rt useful f=
or
> > audio/video applications. =A0Engineering and scientific users find the =
-rt
> > beneficially for servicing hardware like sensors or control systems.
> >
> > If you are just trying to run calculations as fast as you can in user
> > space, you'd be better off using the non-rt variants.
> >
> >
> > --
> > Jeff Angielski
> > The PTR Group
> > www.theptrgroup.com



 Thanks for your response.

On one hand I hear that RT-kernel is meant for reducing kernel latency on
other hand I see that there is RT-kernel overhead. So what really RT-kernel
brings to system performance?

Actually I see that latency for higher priority is more or less same for
non-rt system.

One more thing, since irqs being threaded in RT, and with CFS scheduler in
2.6.33, wouldn't we bring down system performance as CFS is O(log(n)) =A0in
nature?
 --
 Thanks,
 Manik
