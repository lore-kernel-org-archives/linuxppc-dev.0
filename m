Message-ID: <020301bfb967$d0ad94b0$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Dan Malek" <dan@netx4.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
        "Raphael Bossek" <bossekr@debian.org>
Subject: Re: help -- PCMCIA for MPC860
Date: Tue, 9 May 2000 11:36:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

When will you release the patch: PCMCIA for mpc8xx-linux 2.2.13?
It seems that you have completed the work.

The David Hinds's pcmcia-cs and Magnus's patch even
could not pass the compiling.
=============================================================
make[1]: Entering directory `/home/sjzhu/tmp/pcmcia-cs-3.1.10/modules'
powerpc-linux-gcc -fno-builtin -msoft-float -ffixed-r2  -MD -O2 -Wall -Wstri
ct-p
rototypes -pipe -I../include -I/home/sjzhu/linux-2.2.13-embedded/include  -D
__KE
RNEL__ -DMODULE -c cs.c
In file included from ../include/pcmcia/k_compat.h:105,
                 from cs.c:35:
/home/sjzhu/linux-2.2.13-embedded/include/linux/module.h:19:
linux/modversions.h
: No such file or directory
==============================================================

For the kernel, Magnus said that I must modify the kernel, following is the
error:
----------------------------------------------------------------------------
----
make[1]: Entering directory
`/home/sjzhu/linux-2.2.13-embedded/arch/ppc/kernel'
powerpc-linux-gcc -D__KERNEL__ -I/home/sjzhu/linux-2.2.13-embedded/include -
Wall
 -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__power
pc__
 -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized
 -mm
ultiple -mstring -mcpu=860 -I../8xx_io   -c -o m8xx_setup.o m8xx_setup.c
m8xx_setup.c: In function `m8xx_init':
m8xx_setup.c:536: structure has no member named `ide_request_irq'
make[1]: *** [m8xx_setup.o] Error 1
make[1]: Leaving directory
`/home/sjzhu/linux-2.2.13-embedded/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2
----------------------------------------------------------------------------
---------

Thanks,
Shuangjun



-----Original Message-----
From: Dan Malek <dan@netx4.com>
To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
<linuxppc-embedded@lists.linuxppc.org>;
damm@kieraypc01.p.y.ki.era.ericsson.se
<damm@kieraypc01.p.y.ki.era.ericsson.se>
Date: Monday, May 08, 2000 10:53 PM
Subject: Re: help -- PCMCIA for MPC860


>
>Shuangjun Zhu wrote:
>
>> where can I get the code of PCMCIA-IDE for MPC8xx-linux-2.2.13?
>
>Pieces of it are already in the kernel.  Scan the mailing list
>archives to get Mangus' real PCMCIA patches.
>
>In addition to this software, you will need to make (potentially lots of)
>modifications to support powering the cards, unless your hardware folks
>did this for you.
>
>
> -- Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
