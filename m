To: t.vanremortel@ha.be
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling : problem linking 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 15:26:36 +0200."
             <1065101196.10206.7.camel@toni>
Date: Thu, 02 Oct 2003 15:37:34 +0200
Message-Id: <20031002133739.497EEC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1065101196.10206.7.camel@toni> you wrote:
>
> Reduced the error to:
>
> toni rt_mod # make
> ppc_4xx-gcc -g -O -Werror   -c -o rt_mod.o rt_mod.c
> ppc_4xx-gcc -nostartfiles -fno-exceptions -fno-builtin  -o rt_mod
> rt_mod.o
> /opt/eldk/usr/ppc-linux/bin/ld: warning: cannot find entry symbol
> _start; defaulting to 10000184
> rt_mod.o: In function `block_wave':
> /ppc/rt_mod/rt_mod.c:14: undefined reference to `outb'
> /ppc/rt_mod/rt_mod.c:14: relocation truncated to fit: R_PPC_REL24 outb
> rt_mod.o: In function `main':
> /ppc/rt_mod/rt_mod.c:21: undefined reference to `iopl'
> /ppc/rt_mod/rt_mod.c:21: relocation truncated to fit: R_PPC_REL24 iopl
> collect2: ld returned 1 exit status
> make: *** [rt_mod] Fout 1

The header files and/or compiler and linker options you are using are
not correct for the target environment you have.

Without more information (i. e. what sort of code this is and how you
intend it to run - stdandalone, in kernel or in user context)  nobody
can help you.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Sorry, but my karma just ran over your dogma.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
