Message-ID: <3C0567C5.55CF9D64@mvista.com>
Date: Wed, 28 Nov 2001 15:40:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/boot broken include in currenty 2_4_devel
References: <20011128162242.M23942@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy,

Go back one rev of boot/common/Makefile.  I think new one should still work,
tho??

Mark
--

Troy Benjegerdes wrote:

> Somehow, the
>
> CFLAGS  += -fno-builtin -D__BOOTER__ -I$(TOPDIR)/arch/$(ARCH)/boot/include
>
> line in arch/ppc/boot/Makefile is not getting picked up, causeing me
> problems like:
>
> make[3]: Entering directory
> `/scratch/mvp/linuxppc_2_4_galileo/arch/ppc/boot/lib'
> ppc_8xx-gcc -D__KERNEL__ -I/scratch/mvp/linuxppc_2_4_galileo/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
> -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -O2 -ggdb   -c -o
> zlib.o zlib.c
> zlib.c: In function `inflateEnd':
> zlib.c:330: too many arguments to function
> zlib.c: At top level:
> zlib.c:337: parse error before `('
>
> because it's picking up the wrong zlib.h.
>
> I've been messing around with the makefile, but I can't get it to do
> anything that seems sensible.
>
> --
> Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
> -----"If this message isn't misspelled, I didn't write it" -- Me -----
> "Why do musicians compose symphonies and poets write poems? They do it
> because life wouldn't have any meaning for them if they didn't. That's
> why I draw cartoons. It's my life." -- Charles Shulz
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
