To: Jin Cheng <jcheng@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: can not open crt1.o using ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Oct 2002 21:19:49 PDT."
             <3DA25CE5.EA79616B@redswitch.com>
Date: Tue, 08 Oct 2002 07:34:26 +0200
Message-Id: <20021008053431.2C56DFA9C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3DA25CE5.EA79616B@redswitch.com> you wrote:
>
> When I use the ELDK to compile one file, I got the following message saying can
> not
> find crt1.o. Can someone help me on that? I don't have problem compiling one
> other file.
...
> hyperion: 224 % make
> ppc-linux-gcc -D__KERNEL__ -DMODULE -I/u/jcheng/ppclinux/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O -g -DDEBUG -fno-strict-aliasing
> -fno-common -fomit-frame-pointer -I/u/jcheng/ppclinux/arch/ppc -fsigned-char
> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405
> -nostdinc -I/opt/eldk/usr/lib/gcc-lib/ppc-linux/2.95.3/include vayu_main.c
> dbgprint.h:35: warning: `debug' defined but not used
> /opt/eldk/usr/ppc-linux/bin/ld: cannot open crt1.o: No such file or directory
> collect2: ld returned 1 exit status

Please check your compiler options.  If  you're  compiling  a  kernel
module, you should not try linking it as normal binary.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Wisdom is one of the few things that looks bigger the further away it
is.                               - Terry Pratchett, _Witches Abroad_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
