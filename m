Message-ID: <398C3A74.95DFE7BA@esd-electronics.com>
Date: Sat, 05 Jul 2000 18:01:56 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: making kernel for ppc405gp from montavista sources
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I downloaded the linux_tar.gz file from montavista and unpacked it ! I
copied the .config file from the same location to the kernel tree's
root. Before I did a "make mrproper".

When I run a "make dep" I got an error ! Well, I could start to check
out if there is an error in the tree, but I think that there is a
general mistake I made !

Does anybody know where the error comes from ? Here is the output of my
"make dep":

----------------------
mfuchs@pc-matthias:~/mvista_405_linux_new/linux > make dep
make -C arch/ppc/boot fastdep
make[1]: Entering directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/boot'
/home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
make[1]: Leaving directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/boot'
make -C arch/ppc/chrpboot fastdep
make[1]: Entering directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/chrpboot'
/home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
make[1]: Leaving directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/chrpboot'
make -C arch/ppc/treeboot fastdep
make[1]: Entering directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/treeboot'
/home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
make[1]: Leaving directory
`/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/treeboot'
scripts/mkdep init/*.c > .depend
scripts/mkdep `find /home/mfuchs/mvista_405_linux_new/linux/include/asm
/home/mfuchs/mvista_405_linux_new/linux/include/linux
/home/mfuchs/mvista_405_linux_new/linux/include/scsi
/home/mfuchs/mvista_405_linux_new/linux/include/net -follow -name \*.h !
-name modversions.h -print` > .hdepend
make _sfdep_kernel _sfdep_drivers _sfdep_mm _sfdep_fs _sfdep_net
_sfdep_ipc _sfdep_lib _sfdep_arch/ppc/kernel _sfdep_arch/ppc/mm
_sfdep_arch/ppc/lib _FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc
lib arch/ppc/kernel arch/ppc/mm arch/ppc/lib"
make[1]: Entering directory `/home/mfuchs/mvista_405_linux_new/linux'
make -C kernel fastdep
make[2]: Entering directory
`/home/mfuchs/mvista_405_linux_new/linux/kernel'
make[2]: *** No rule to make target
`/home/mfuchs/mvista_405_linux_new/linux/include/linux/autoconf.h',
needed
by
`/home/mfuchs/mvista_405_linux_new/linux/include/linux/modules/signal.ver'.
Stop.
make[2]: Leaving directory
`/home/mfuchs/mvista_405_linux_new/linux/kernel'
make[1]: *** [_sfdep_kernel] Error 2
make[1]: Leaving directory `/home/mfuchs/mvista_405_linux_new/linux'
make: *** [dep-files] Error 2
mfuchs@pc-matthias:~/mvista_405_linux_new/linux >
--------------------------------------

thanks for advise
Matthias

--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
