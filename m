Message-ID: <38C3B4AE.A0C5EB73@ict.ac.cn>
Date: Mon, 06 Mar 2000 21:37:50 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem on MPC8xx
References: <NCBBKJKKGDLPHKDPAFFMIECLCDAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jason:

I am sorry that another problem appeared.
After the /bin/sh ran, I can't see anything from console.
I open the compile switch "SERIAL_DEBUG_INTR" in uart.c,
then I can see the following message on console:

THRE...rs_interrupt_single(0, 2)...end.
THRE...rs_interrupt_single(0, 2)...end.
.
.
.

It means that the transmit interrupt is triggered, right?
But why I can't see anything?
And can you tell me that when shell outputs message to console,
which function it uses in uart.c? I think it should be
rs_8xx_write(), right? But I found that this function was not
called before interrupt happened.

Thanks!

LiuTao

>
> I'm glad to hear you resolved your problem.  If I can lend you any other
> assistance, let me know, I have gone all the way through porting the kernel
> to a custom 860 board now and are familiar with solutions to some stumbling
> blocks.
>
> Jason
>
> -----Original Message-----
> From: LiuTao [mailto:tliu@ict.ac.cn]
> Sent: Thursday, March 02, 2000 5:24 AM
> To: Jason Wohlgemuth
> Subject: Re: problem on MPC8xx
>
> Hi Jason:
>
> Thanks for your attention!
> I found the problem in uart.c, the BRG is setup incorrectly.
> I have resolved the problem.
> Now, I can see message from console port.
>
> Thanks.
>
> LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
