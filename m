Message-Id: <5.0.2.1.0.20010402165636.00b02008@pop.ylez.com>
Date: Mon, 02 Apr 2001 17:00:22 +0800
To: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
From: Leonard Ye <leonard_ye@ylez.com>
Subject: Re: kernel support of MPC8XX series 
In-Reply-To: <20010330074730.42B7E28827@denx.denx.de>
References: <Your message of "Fri, 30 Mar 2001 13:21:55 +0800." <5.0.2.1.0.20010330132041.00a65958@pop.ylez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

Thanks for your information.  For the embedded system that I am going to
develop, kernel 2.4 and PCMCIA is a must.  Have you get them working on
MPC8XX platform, especially MPC855?  I have read the HOWTO, it just tell me
MPC8XX is support without any specific information.

Regards,
Leonard Ye

At 03:47 PM 3/30/2001, Wolfgang Denk wrote:
>Hi Leonard,
>
>in message <5.0.2.1.0.20010330132041.00a65958@pop.ylez.com> you wrote:
> >
> > Just want to ask a very simple question. How is the kernel support on
> > MPC8XX series, especially on the MPC855 and MPC860? I will be very happy if
> > kernel 2.4 can be used and PCMCIA is support as well.
>
>Kernel support for the 8xx has been available for well over 2  years.
>We use it in many customer projects.
>
>PCMCIA support is available, too, but need some  work,  depending  on
>hwat  you  are  going  to  do.  For  most embedded systems the PCMCIA
>package is just overkill, so simpler solutions may  be  useful  -  we
>have done this for storage devices (hard disks, CompactFlash, etc.).
>
>Feel free to ask if you need details.
>
>In the meantime, check the excellent embedded PPC FAQ at
>http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO.html
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>"He only drinks when he gets depressed." "Why does he get depressed?"
>"Sometimes it's because he hasn't had a drink."
>                                      - Terry Pratchett, _Men at Arms_


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
