Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <wd@denx.de>
Cc: "'Mailing List: linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: A question on kernel clock: 
Date: Tue, 30 Dec 2003 18:45:42 +0800
Message-ID: <000501c3cec2$130dbab0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20031230102235.32DD9C12DD@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Wolfgang,

Thanks very much and Happy New year to you and your family!

I'm sorry for my simple question description.

The processor I mentioned is MPC82xx. Now, I have kernel from kernel.org
run on the board. But, my "nsleep()" is not exactly. So, I want to
realize the timer mechanism of Linux used.

(1) which timer is used for nsleep?

(2) can udelay() be changed to be preempted by other process?

(3) which is good choice for Kernel timeslice?

Additional, could we develop a bootloader like vxworks' bootloader? (
vxworks bootloader is a little vxworks, I think.)

John

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Tuesday, December 30, 2003 6:23 PM
Subject: Re: A question on kernel clock:

in message <000301c3ce9e$ff345440$b702a8c0@newrock2> you wrote:
>
> A question on kernel clock:

I wish you would explain in a bit more detail what you are talking
about...

> Normally, which is kernel clock source? Can we use any one of

Normally the kernel clock source is a quartz oscillator.

Or what do you mean? "clock source" can mean different things to
different people and may be different on differenrt processors.

The kernel uses the decrementer for the system tick.

> BRG1-8? Can we use bus clock? Which is good for choice?

Use BRG1-8? On which processor? What for?

Good for choice? On which hardware? For which purpose?

> Can anyone give me some suggestions?

Yes: please ask more specific questions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
