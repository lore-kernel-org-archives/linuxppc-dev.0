Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 26E842BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 04:34:35 +1100 (EST)
Message-ID: <4190FE1F.4080105@esteem.com>
Date: Tue, 09 Nov 2004 09:27:59 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Peter Asemann <peter.asemann@web.de>
References: <418F83C4.5000109@web.de>
In-Reply-To: <418F83C4.5000109@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How much easier makes owning a BDI2000 things?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Asemann wrote:
> The tutorials in the web I read about getting custom hardware running
> suggest that having some BDI-thing like an Abatron BDI2000 is a really
> good idea.
> 
> Actually I need some arguments to have such a device bought. How much
> easier does it make things?
> 
> Peter Asemann
> 


	Its worth it weight in gold bringing up custom boards the first time 
and writing/debuging the boot rom. It allows you to change register 
values for esential functions such as PLL setings, memory timings and 
peripheral configuration. This is very handy because you can figure out 
the values you need before you write the boot rom software. It also 
allows you to reprogram flash memory in circuit. To do it without this 
you would need to have removable flash/roms and remove, reprogram and 
replace them each attempt. I would imagine doing that would get old very 
fast.

	We haven't used ours much for debugging once things were up and 
running(we have fallen back to using printk statements for debugging). 
Though it can be used for that and some core kernel developers do use 
it. (probably for debugging the printk code of the kernel  ;-)  )

	In production we use it to program the boot rom on brand new boards. It 
is also occasionaly usefull in finding faults in boards that don't want 
to come up.

	To sum things up let me put it this way. I could theoretically bring up 
a board without one. I can't imagine how much longer it would take to do 
so however.

-- Conn Clark

*****************************************************************
Give a man a match and you heat him for a moment. Set him on fire
and you'll heat him for life.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST
