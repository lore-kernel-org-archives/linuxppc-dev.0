Return-Path: <tony.p.lee@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.205])
	by ozlabs.org (Postfix) with ESMTP id BB1462BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Oct 2004 14:26:45 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so154633rnk
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 09 Oct 2004 21:26:37 -0700 (PDT)
Message-ID: <470b6397041009212664b9c80e@mail.gmail.com>
Date: Sat, 9 Oct 2004 21:26:37 -0700
From: Tony Lee <tony.p.lee@gmail.com>
To: jonathan@jonmasters.org
In-Reply-To: <35fb2e59041009122710ab6d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>
	<35fb2e5904100508157a393ee2@mail.gmail.com>
	<4162C649.6060900@ru.mvista.com>
	<35fb2e590410051507367017a@mail.gmail.com>
	<41641222.6080405@ru.mvista.com>
	<470b63970410071534422f6617@mail.gmail.com>
	<4165DB83.8080001@jonmasters.org>
	<470b6397041007195371655afb@mail.gmail.com>
	<35fb2e59041009122710ab6d53@mail.gmail.com>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Luca Giuliani <l.giuliani@tiscali.it>, linuxppc-embedded@ozlabs.org
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
Reply-To: Tony Lee <tony.p.lee@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 9 Oct 2004 20:27:15 +0100, Jon Masters <jonmasters@gmail.com> wrote:
> On Thu, 7 Oct 2004 19:53:52 -0700, Tony Lee <tony.p.lee@gmail.com> wrote:
> 
> > The problem I saw was that I can't turn off the interrupt at all.
> 
> On the Memec board? really?
> 

No, not on Memec,  just on our own HW.    I have the memec board, but
I don't have time to play on that one.   I got to debug the HW one week after
I was hired.    As far as I can tell, our linux for memec board doesn't load
the sysace driver.


> > Once I start one write command, the ISR keep coming in.
> 
> Ouch.

Tell me about it.  It tooks me 3+ days to id this.

> Perhaps. But that's down to your hardware guys to check the error
> output from your synthesis tool to see if this weirdly has happened.
> Our board doesn't have lines hard tied together, if that was the
> notion you were offering.

I tried to synthesize chipscope into into our VP20.  But don't have
much time for it now.  It is less of a priority since the sysace is working 
now for 1.5 months (without ISR).  Also, we use linux as Xilinux dev environment
but the chipscope only work in Windows platform.  Our HW folks
don't have time to touch Windows side of Xilinx tools.  It make it
more difficult to debug SW/HW integration issue.


> 
> > I try turn off the ISR on write with SYSACE register and
> > the ppc interrupt control register.  None of them worked.
> 
> Did you do it as per my patch, or what?

No, where can I find your patch?

> 
> Yes. We come up in 8 seconds to my firmware, and total boot time is
> around 20 seconds, without any effort to make it less. That includes
> cunning DHCP+ZeroConf scripts I wrote.
> 

That's about right,  We don't do DHCP, it comes up a bit faster.

-- 
-Tony
Having a lot of fun with Xilinx Virtex Pro II reconfigurable HW + ppc + Linux
