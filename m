Date: Tue, 24 Oct 2000 02:18:16 +1300
From: Gwyn Judd <b.judd@xtra.co.nz>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: 2.2.18-pre17 woes (COMPAQ_CISS_MAJOR undefined)
Message-ID: <20001024021816.A2578@thislove>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't even have this driver enabled. Anyone else get this? Also when I
switched to the cvs tree on ppc.samba.org (I think) for the last month
or so I wasn't getting any updates until only today. I guess whatever
was wrong they have fixed anyway.

[gwyn@thislove:/usr/src/linux]$ make
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -DUTS_MACHINE='"ppc"' -c -o init/version.o init/version.c
make -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: Leaving directory `/usr/src/linux/kernel'
make -C  drivers
make[1]: Entering directory `/usr/src/linux/drivers'
make -C block
make[2]: Entering directory `/usr/src/linux/drivers/block'
make all_targets
make[3]: Entering directory `/usr/src/linux/drivers/block'
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring   -DEXPORT_SYMTAB -c ll_rw_blk.c
ll_rw_blk.c: In function `add_request':
ll_rw_blk.c:527: `COMPAQ_CISS_MAJOR' undeclared (first use in this
function)
ll_rw_blk.c:527: (Each undeclared identifier is reported only once
ll_rw_blk.c:527: for each function it appears in.)
ll_rw_blk.c: In function `make_request':
ll_rw_blk.c:679: `COMPAQ_CISS_MAJOR' undeclared (first use in this
function)
make[3]: *** [ll_rw_blk.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2
[gwyn@thislove:/usr/src/linux]$


--
Gwyn Judd (b.judd@xtra.co.nz)
It must be remembered that we have only heard one side of the case. God
has written all the books.
-Samuel Butler

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
