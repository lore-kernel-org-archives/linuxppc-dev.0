Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <002c01c279f8$43c269a0$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <20021001184101.EF497FA97@denx.denx.de>
Subject: Re: Downloading Linux image using Riscwatch
Date: Tue, 22 Oct 2002 23:54:31 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have ported rom monitor code[Openbios from IBM] for my custom
board[PPC440GP Processor]. The custom board doesn't support ethernet. Now I
want to download a linux image to the RAM of my custom board. What linux
image I have to build to download to RAM using JTAG of Riscwatch Debugger .

Thanking you in advance
Regards
Aman

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, October 02, 2002 12:10 AM
Subject: Re: Downloading Linux image using Riscwatch


> In message <001b01c26976$233e0640$370da8c0@aman> you wrote:
> >
> >  I am using PPC 440GP processor on custom board. This board doesnt not
have
> >  Ethernet support and there is no rom monitor code in the board. Is it
> >  possible to download the Linux image to the board using JTAG . If so
what
> >  type of image should I build.
>
> You can download the kernel, but it will not run ;-)
>
> The Linux kernel relies on a lot of initialization to be done by  the
> firmware  -  things  like initializing and sizing the memory, passing
> boot arguments etc.
>
> I suggest you start porting PPCBoot.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The first 90% of a project takes 90% of the time, the last 10%  takes
> the other 90% of the time.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
