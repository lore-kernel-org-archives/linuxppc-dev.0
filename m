Subject: Re: cant't stop program
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Dan Kegel <dank@kegel.com>
Cc: sun-zj <sun-zj@tdk-tech.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3FF8E408.8060507@kegel.com>
References: <200401050235.UAA05095@lists.linuxppc.org>
	 <3FF8E408.8060507@kegel.com>
Content-Type: text/plain
Message-Id: <1073317888.27086.19.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 16:51:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I sometimes (!) see the same problem when running from serial
console. Telnet works ok. I did change in my kernel
driver/char/tty_io.c to set noctty = 0;

It seems that in shell/ash.c from busybox the call
(pgrp = tcgetpgrp(fd)) returns an error
code.

Jaap-Jan

On Mon, 2004-01-05 at 05:11, Dan Kegel wrote:
> sun-zj wrote:
> > After the denk's instruction, I can run the
> > linuxppc-2.4.23 on PPC8xx without too much difficulty. But when running some
> > programming , I want to terminate it like I do on PC by press Ctrl+C.
> > It doesn't work at all :(. It can work under the U-boot environment. I
> > wonder whether this is the
> > problem of Linux os Or Kermit?
>
> I have seem problems like that when running from serial
> console under Busybox.  I think busybox's init is buggy.
> Does the problem happen when you telnet in from another computer,
> or only on a serial console?
> - Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
