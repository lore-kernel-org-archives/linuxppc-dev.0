To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: =?utf-8?B?R2FyY2lhIErDqXLDqW1pZQ==?= <GARCIAJ@3il.fr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling assembler file with ppc_405-gcc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 09:55:29 PDT."
             <E8E581FE5C58614B85A22AF2A495C64909E410@uschd00mx11usr.AVNET.COM>
Date: Fri, 11 Jun 2004 19:47:38 +0200
Message-Id: <20040611174743.7C817C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <E8E581FE5C58614B85A22AF2A495C64909E410@uschd00mx11usr.AVNET.COM> you wrote:
>
> No Wolfgang, read it again: he is running ppc_4xx-gcc.  It's in a
> variable named $(AS), but he is running the C compiler.  It is

You're right. Sorry.

> reasonable to expect #include and #define statements to work --
> after all, the Linux build does this all the time!  As does the
> u-boot build:
>
> $ cd /opt/gx/u-boot
> $ make
> ...
> ppc_4xx-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os   -fPIC -ffixed-r14 -meabi
> -D__KERNEL__ -DTEXT_BASE=0xFFF80000 -I/opt/gx/u-boot/include -fno-builtin
> -ffreestanding -nostdinc -isystem /opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.4/include
> -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -ffixed-r29 -mstring
> -Wa,-m405 -mcpu=405 -msoft-float -DCONFIG_440=1 -c -o init.o
> /opt/gx/u-boot/board/avnet_440gx_eval/init.S

Mind the file name - <name>.S --> upper case letter 'S'

> > > ppcsiafn.o:
> > >       $(AS) $(CFLAGS_AS) -c
> > $(SRC_PATH)/startup/init/ppcsiafn.s -o ppcsiafn.o

And here: <name>.s --> lower case letter 's'.


>From the GNU manual:

	`FILE.s'
	     Assembler code.

	`FILE.S'
	     Assembler code which must be preprocessed.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nobody trips over mountains. It is the small pebble that  causes  you
to  stumble.  Pass all the pebbles in your path and you will find you
have crossed the mountain.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
