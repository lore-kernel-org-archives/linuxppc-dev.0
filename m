From: acmay@acmay.homeip.net
Date: Sat, 21 Jul 2001 15:32:03 -0700
To: Iain Young <iain@g7iii.junglelink.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: process.c Assembler Message Error: unsupported relocation type
Message-ID: <20010721153203.C470@sink.san.rr.com>
References: <20010721115321.A484@g7iii.junglelink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010721115321.A484@g7iii.junglelink.co.uk>; from iain@g7iii.junglelink.co.uk on Sat, Jul 21, 2001 at 11:53:21AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 21, 2001 at 11:53:21AM +0100, Iain Young wrote:
> make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4-sparc/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403 " -C  arch/ppc/kernel
> make[1]: Entering directory `/usr/src/linux-2.4-sparc/arch/ppc/kernel'
> powerpc-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4-sparc/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403    -c -o process.o process.c
> process.c: In function `copy_thread':
> process.c:327: warning: unused variable `msr'
> {standard input}: Assembler messages:
> {standard input}:394: Error: unsupported relocation type
> {standard input}:395: Error: unsupported relocation type
> {standard input}:396: Error: unsupported relocation type
> {standard input}:400: Error: unsupported relocation type
> {standard input}:401: Error: unsupported relocation type
> {standard input}:402: Error: unsupported relocation type
> make[1]: *** [process.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4-sparc/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2

Probably from the includes and code not having the correct DCR's for your chip.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
