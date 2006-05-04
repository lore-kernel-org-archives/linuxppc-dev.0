Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 099CA67A42
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 05:51:28 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so799106pye
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 May 2006 12:51:27 -0700 (PDT)
Message-ID: <b4b98b690605041251s40f88731i1edfdfb324da38b4@mail.gmail.com>
Date: Thu, 4 May 2006 12:51:26 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: dhlii@comcast.net
Subject: Re: kernel debugging
In-Reply-To: <4459C774.8000300@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com>
	<4459C774.8000300@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/4/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     Everyone has their own debugging style.
>
>     Engineers seem to like hardware debugging tools. I have used some
> very fancy debugging hardware, but except for extremely rare instances
> it is more work to get setup
>     and figure out what you are trying to do than inserting some
> debugging and rebuilding.
>
>     My idea of debugging hardware is a port with an LED on it I can try
> to blink.
>
>     I also only rarely use software debuggers.
>
>     Most of the time when things go off the rails the critical question
> for me is Where did things go wrong. Once I know that usually the
> problem is obvious and I do nto need dumps of variables or memory.
>
>     I also do development across numerous platforms, OS's and languages.
> I need debugging tools and techniques that are broadly portable. A
> hardware debugging tool might help with board bringup, but it would be
> of little use
>     for web or perl programming. Investing time and capitol in highly
> specialized tools or knowledge requires being narrowly focused to get a
> worthwhile payback.
>
>     Regardless, I think debugging is a sort of religious preference. You
> need to know who you are and what you need. Other peoples experience is
> useful but should not be determinative.
>

Yes I am finding this out.  It's a long journey!  :)

Most of the issues I have to deal with are systems that are already up
and running in the PPC world and I come in afterwords to clean up.  So
for example, right now I think I have a DMA problem that is crashing
my PPC and rebooting the system.

To be sure, I would love to step over a few instructions and slow the
world down a bit.  That's why I was going to setup kgdb or something
like that.

Thanks.

-stv


> Steve Iribarne (GMail) wrote:
> > Hello.
> >
> > This is more a general question to see what others do out here.  I am
> > begining to get sick of printk debugging.  I work on two different PPC
> > boards.  An 860 and 8260.
> >
> > I want to get some feedback on the best kernel debugger to use.  I
> > have been looking at three.
> >
> > 1.  kgdb
> > 2.  kdb
> > 3.  UML
> >
> > I am leaning towards kgdb, but before I jump in I thought I'd put this
> > out to the best group I could think of linuxppc.  Because I am sure
> > most of you are using something!  :)
> >
> > Thanks.
> >
> > -stv
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>
> --
> Dave Lynch                                              DLA Systems
> Software Development:                                Embedded Linux
> 717.627.3770         dhlii@dlasys.net         http://www.dlasys.net
> fax: 1.253.369.9244                            Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies too n=
umerous to list.
>
>
