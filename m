To: cjohnson@gcctech.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Jan 2004 11:48:31 EST."
             <4016965F.5060706@gcctech.com>
Date: Tue, 27 Jan 2004 18:13:56 +0100
Message-Id: <20040127171401.93025C108D@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <4016965F.5060706@gcctech.com> you wrote:
>
> Problem #1: When I start host side gdb, I get the message:
> warning: unable to find dynamic linker breakpoint function
> GDB will be unable to debug shared library initializers
> and track explicitly loaded dynamic code

You missed to set solib-absolute-prefix - see
http://www.denx.de/twiki/bin/view/DULG/DebuggingApplication#Section_9.5.2.

> The program starts and breakpoint don't work.
>
> Problem #2:  (Maybe related?) on the target side gdbserver, after
> starting things with "c" on the host side, this message appears:
> gdb: error initializing thread_db library.
> gdb: error initializing thread_db library.
>
> Yes, twice.

Well, guess what that means?

> Why is gdbserver on the target having trouble?  I see I have correctly
> delivered the thread_db library in /lib on the target, so what gives?

Probably you have other problems with your build of GDB /  gdbserver.
We had to fix a couple of problems to get thread support working.

> Any help or guidance would be greatly appreciated.  I build my toolchain
> with crosstools.

Feel free to try out the GDB / gdbserver that come with the ELDK.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The moral of the story is: "Don't stop to  tighten  your  shoe  laces
during the Olympics 100m finals".
                             - Kevin Jones in <DEJo68.K1t@bri.hp.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
