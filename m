To: engineersong@hanmail.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 console problem on MPC860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Mar 2001 09:58:39 +0700."
             <20010330095839.HM.30000000001Zxx8@www4.hanmail.net>
Date: Fri, 30 Mar 2001 09:53:54 +0200
Message-Id: <20010330075359.4273128827@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010330095839.HM.30000000001Zxx8@www4.hanmail.net> you wrote:
>
> I would like to use SCC3 as second console, and use SMC1 as first console.
> I ported denx kernel 2.4.3-pre4 into my 860 board.
> when I compiling, checked SCC3 for UART option in MPC8xx CPM option.
> SMC1(ttyS0) is connected to my linux box COM2, SCC3(ttyS1) is connected to COM1.

What's the kernel output for the serial ports? Please send me your kernel boot messages!

> After booting, in COM2 echo 1111 > /dev/ttyS1 result is shown in SCC3(ttyS1).
> so far good.
> but, COM1 port don't any receive keyboard key.

Please define what you mean by COM1 and COM2.

How did you test this?

> In /arch/ppc/uart.c
> I modified CONFIG_SERIAL_CONSOLE_PORT for SCC3 console
>
> #if 1
> #undef CONFIG_SERIAL_CONSOLE_PORT
> #define CONFIG_SERIAL_CONSOLE_PORT	1
> #endif

If in your configuration SCC3 is the second entry in rs_table[], then
this should work.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God made machine language; all the rest is the work of man.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
