Message-ID: <4016760E.50009@g-house.de>
Date: Tue, 27 Jan 2004 15:30:38 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: linux-2.4-benh compiling error
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi,

i was about to compile linux-2.4-benh (fresh tree fetched via rsync)
when errors occured:

[...]
make[3]: Entering directory
`/data/MP3/scratch/kernel/linux-2.4-benh/drivers/char'
gcc -D__KERNEL__ -I/data/MP3/scratch/kernel/linux-2.4-benh/include -Wall
- -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
- -fomit-frame-pointer -I/data/MP3/scratch/kernel/linux-2.4-benh/arch/ppc
- -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized
- -mmultiple -mstring   -nostdinc -iwithprefix include
- -DKBUILD_BASENAME=defkeymap  -c -o defkeymap.o defkeymap.c
defkeymap.c:1: error: parse error before "defkeymap"
In file included from
/data/MP3/scratch/kernel/linux-2.4-benh/include/linux/types.h:15,
~                 from defkeymap.c:6:
/data/MP3/scratch/kernel/linux-2.4-benh/include/linux/posix_types.h:38:
warning: type defaults to `int' in declaration of `__kernel_fd_set'
/data/MP3/scratch/kernel/linux-2.4-benh/include/linux/posix_types.h:38:
warning: data definition has no type or storage class

line-wrapping sucks, heres the full log and more info:

http://nerdbynature.de/bits/sheep/2.4.24-benh/make.log
http://nerdbynature.de/bits/sheep/2.4.24-benh/config
http://nerdbynature.de/bits/sheep/2.4.24-benh/ver_linux

i was told the 2.4-benh tree could fix some PReP annoyances (sp?) too,
so i wanted to try it out.

Thank you for your time,
Christian.

- --
BOFH excuse #259:

Someone's tie is caught in the printer, and if anything else gets
printed, he'll be in it too.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
