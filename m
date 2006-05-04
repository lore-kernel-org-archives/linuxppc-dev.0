Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EE5B679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 11:35:25 +1000 (EST)
Message-ID: <4459C774.8000300@dlasys.net>
Date: Thu, 04 May 2006 05:20:52 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
Subject: Re: kernel debugging
References: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com>
In-Reply-To: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Everyone has their own debugging style.

    Engineers seem to like hardware debugging tools. I have used some
very fancy debugging hardware, but except for extremely rare instances
it is more work to get setup
    and figure out what you are trying to do than inserting some
debugging and rebuilding.

    My idea of debugging hardware is a port with an LED on it I can try
to blink.

    I also only rarely use software debuggers.

    Most of the time when things go off the rails the critical question
for me is Where did things go wrong. Once I know that usually the
problem is obvious and I do nto need dumps of variables or memory.

    I also do development across numerous platforms, OS's and languages.
I need debugging tools and techniques that are broadly portable. A
hardware debugging tool might help with board bringup, but it would be
of little use
    for web or perl programming. Investing time and capitol in highly
specialized tools or knowledge requires being narrowly focused to get a
worthwhile payback.
   
    Regardless, I think debugging is a sort of religious preference. You
need to know who you are and what you need. Other peoples experience is
useful but should not be determinative.

Steve Iribarne (GMail) wrote:
> Hello.
>
> This is more a general question to see what others do out here.  I am
> begining to get sick of printk debugging.  I work on two different PPC
> boards.  An 860 and 8260.
>
> I want to get some feedback on the best kernel debugger to use.  I
> have been looking at three.
>
> 1.  kgdb
> 2.  kdb
> 3.  UML
>
> I am leaning towards kgdb, but before I jump in I thought I'd put this
> out to the best group I could think of linuxppc.  Because I am sure
> most of you are using something!  :)
>
> Thanks.
>
> -stv
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 						DLA Systems
Software Development:  				     Embedded Linux
717.627.3770 	     dhlii@dlasys.net 	      http://www.dlasys.net
fax: 1.253.369.9244 			       Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.
