Message-ID: <3A23F07A.FF2F643@mvista.com>
Date: Tue, 28 Nov 2000 09:50:50 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Nguyen Xuan Hoang <jerry.nguyen@serialsystem.com.sg>
CC: support@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Card Service
References: <DKEFKEENEHPHKNLLKHCGGEEICDAA.support@mvista.com> <005201c059b0$2cdef7e0$ef0fa8c0@hoangmobile>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nguyen Xuan Hoang wrote:
>
> Hi,
>
> I'm trying to get the PCMCIA CardService  running on an mpc823 board
> (RPX Lite). I pick up the code from Jo-Ellen Mathews of AbsoluteValue
> Systems,and I can do something like remap memory, read data from IO
> port...But end up with IRQ probe fail (I start with PCMCIA Flash Card).  I
> did an investigating and find out the reason, that is PCMCIA card service
> already occupy the PCMCIA interrupt and I can not use request_8xxirq to
> register another handler .
>
> I am thinking that I may have to rewrite request_8xxirq and pcmcia interrupt
> handler to solve this case. Is there any better solution? Have any one have
> done it? I am very appreciated for any help.

yeah, I have done it.  use my patches on
ftp://ftp.mvista.com/pub/Area51/ppc_8xx.  I still have not done a
README, but if you have a MV support contract just contact support and
they will help you out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
