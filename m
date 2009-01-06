Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 65609DE26D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 01:21:58 +1100 (EST)
In-Reply-To: <4962AA31.6020408@genesi-usa.com>
References: <1231160724_126472@mercury.realtime.net>
	<4962AA31.6020408@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aecc6404feb17e05e751dc7bade4b837@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: use common cpu_die
Date: Tue, 6 Jan 2009 08:28:52 -0600
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

#insert top_post

On Jan 5, 2009, at 6:47 PM, Matt Sealey wrote:

> Milton you're amazing <3
>
> This is going to take a while to test. I have to build a new source 
> rpm and push it to Peter, who is doing some work and I need him to 
> have working config the same as mine. I am build testing the patch in 
> parallel here.. maybe I will have a kernel tonight or maybe tomorrow.

That's why I did't try to test.  I'll leave it to your schedule.

> We have to do a run test on Pegasos and Efika and MPC8610 as well as 
> the dual core, and I will be busy at University tomorrow anyway poking 
> around with an analyzer..
>
> What's your preferred, easiest way to test a system being put into a 
> sleep mode? I was planning on echo mem >/sys/power/state.

I was mostly intrested in what happened, ie does it immediately oops on 
smp, and if setting the smp ops to the generics would cause it to fail 
gracefully or possibly even sleep.

> My fear is basically, that even if the system successfully goes in, 
> whether I will be able to get it back out again.
>
> I've never bothered to even check it works because my last experience 
> with it on my EPIA and Pegasos has been, it never unsleeps, or it 
> oopses the kernel like crazy rather than sleeping (or comes out and 
> locks up..). I gather this is what we don't want to see.. but how do I 
> tell if it's broken as usual, or broken from this? :D

If you don't have sleep working, why are you configuring SUSPEND ?  
Does it work up? up with power mac?

milton
