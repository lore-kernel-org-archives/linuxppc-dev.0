Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 15 Aug 2003 11:00:41 -0700
From: Ron Bianco <ronb@lcsaudio.com>
Subject: RE: MPC7410 doesn't work with linux-2.4.20-denx
In-reply-to: <20030815084215.BE92CC59E4@atlas.denx.de>
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <000301c36357$240d93c0$4d00a8c0@warp-speed>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm curious as to what an MPC8260 is doing on a board based on an MPC7410?
Is this a dual processor board?

Ron

>
> Dear Christian,
>
> in message <200308141128.h7EBSnQ06089@mailgate5.cinetic.de> you wrote:
> >
> > I'm currently trying to get linux running on an embedded board:
> > 	* MPC7410 Rev.1.4
> > 	* PowerQUICC (MPC 8260)
> > 	* RAM: 128 MB
> > 	* Flash: 64 MB
> > 	* Kernel: 2.4.20-denx
> >
> > For some reason, it doesn't boot properly. It says "Now booting Linux",
> > after that something triggers a hard reset. For the last 2 weeks I tried
>
> A couple of questions:
>
> * Which bootloader are you using?
> * Are you sure that the SDRAM initialization is correct?
> * Are you sure the information passed from the bootloader to the Linux
>   kernel (memory size, clocks, ...) is correct?
> * Finally: did you disable the software watchdog?
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> If you fail to plan, plan to fail.
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
