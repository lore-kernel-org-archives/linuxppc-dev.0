Return-Path: <egan@timesys.com>
Received: from santa.timesys.com (65-117-135-105.dia.cust.qwest.net
	[65.117.135.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93AD7688E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 03:53:54 +1100 (EST)
Received: from santa.timesys.com (localhost.localdomain [127.0.0.1])
	by santa.timesys.com (8.12.11/8.12.11) with ESMTP id jBJFvsf4014107
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Dec 2005 10:57:54 -0500
From: Egan <tony.egan@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17318.55426.526781.62414@santa.timesys.com>
Date: Mon, 19 Dec 2005 10:57:54 -0500
To: linuxppc-embedded@ozlabs.org
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <200512191039.58149.david.jander@protonic.nl>
References: <20051219123941.25BE7688FE@ozlabs.org>
Subject: Re: POSIX High Resolution Timers in LinuxPPC 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > Hi Tim,
 > 
 > On Friday 16 December 2005 23:34, Martin, Tim wrote:
 > > Could someone give me a brief history lesson on POSIX high resolution
 > > timers (e.g. timer_create() function) implemented in the Linux kernel on
 > > the PowerPC 405 architecture?  Specifically:
 > >
 > > Confirm they are in the mainline 2.6 kernel now (e.g. kernel.org)?
 > >
 > > Were they ever a part of the "mainline" 2.4 linuxppc kernel (e.g
 > > ppc.bkbits.net)?
 > >
 > > If no, were they ever available as a patch? The stuff at
 > > sourceforge.net/projects/high-res-timers stops at 2.4.20 and looks like it
 > > was only ever working for i386, not ppc.
 > 
 > I asked a related question a while back, and got no answer (yet).
 > I did find this though, which you might have overlooked:
 > http://prdownloads.sourceforge.net/high-res-timers/ppc-hrt-2.6.10.patch?download
 > 
 > I am equally puzzled about whether this has made it into mainstream, is about 
 > to, or never will. I don't even know if it actually works.
 > 
 > Greetings,
 > 
 > -- 
 > 
 > David Jander
 > Protonic Holland.
 > 

High resolution timer support has been rewritten for 2.6 by Thomas Gleixner
with help from Ingo Molnar and others and is available at:
http://tglx.de/hrtimers.html.  It is also integrated into Ingo's
realtime-preempt patch at: http://people.redhat.com/mingo/realtime-preempt/.
It is not available in the mainline kernel yet.  Currently only X86 is
supported, PPC and other architectures are reported to be in progress.  If you
monitor the LKML you will see a lot of discussion/development in this area
right now.

Regards,
Tony
