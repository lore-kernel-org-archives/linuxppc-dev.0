To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling : problem linking 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 14:56:56 +0200."
             <1065099415.10206.5.camel@toni>
Date: Thu, 02 Oct 2003 15:35:24 +0200
Message-Id: <20031002133529.305B6C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1065099415.10206.5.camel@toni> you wrote:
>
> I try to cross compile a small test program for the EP505 board. I use
> ELDK as compiler set.
>
> When using this compile command:
>
> ppc_4xx-gcc -O -v -nostdlib -nostartfiles -mno-eabi -fno-exceptions \
> -fno-builtin -Wl,-Tscript.ld,-N -o rt_mod rt_mod.c

Well, I guess you know what you are  douing  here,  i.  e.  what  the
linker options mean?

I wonder where you got this command line from...

> I get after a while:
>
> /opt/eldk/usr/ppc-linux/bin/ld: cannot open linker script file \
> script.ld: Onbekend bestand of map
> collect2: ld returned 1 exit status
>
> I don't know what is wrong, but 'script.ld' isn't anywhere on my system.

Well, if you don't have such a linker script, why do  you  then  tell
the linker to use it?

> PS: the program currently should make a square wave on EBC P1 D1

In which sort of environment? As standalone program? As Linux  kernel
module? As Linux user-land application? Or what?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Uncertain fortune is thoroughly mastered by the equity of the  calcu-
lation.                                               - Blaise Pascal

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
