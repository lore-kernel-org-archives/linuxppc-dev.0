Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200405180149.i4I1niRV001354@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: ELDK help
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 18 May 2004 09:49:43 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
     ELDK worked for me greatly before. Just a few days ago,I found that
when I not use make clean, things work ok. However when I make clean and
make uImage, the following error message appears:

 scripts/mkversion > .tmpversion
ppc_82xx-gcc -D__KERNEL__ -I/root/new/4.1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/root/new/4.1/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring  -DUTS_MACHINE='"ppc"' -DKBUILD_BASENAME=version -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/root/new/4.1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/root/new/4.1/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring " -C  kernel
......
make[2]: Entering directory `/root/new/4.1/drivers/char'
make -C joystick
make[3]: Entering directory `/root/new/4.1/drivers/char/joystick'
make all_targets
make[4]: Entering directory `/root/new/4.1/drivers/char/joystick'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory `/root/new/4.1/drivers/char/joystick'
make[3]: Leaving directory `/root/new/4.1/drivers/char/joystick'
make all_targets
make[3]: Entering directory `/root/new/4.1/drivers/char'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/root/new/4.1/arch/ppc -o conmakehash conmakehash.c
/tmp/cck3aG7b.s: Assembler messages:
/tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
/tmp/cck3aG7b.s:2: Warning: Unrecognized .section attribute: want a,m,s,w,x
/tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
/tmp/cck3aG7b.s:155: Warning: Unrecognized .section attribute: want a,m,s,w,x
/usr/local/bin/ld: unrecognized option '--eh-frame-hdr'
/usr/local/bin/ld: use the --help option for usage information
collect2: ld returned 1 exit status
make[3]: *** [conmakehash] Error 1
make[3]: Leaving directory `/root/new/4.1/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/root/new/4.1/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/root/new/4.1/drivers'
make: *** [_dir_drivers] Error 2

  It seems that the toolchain is broken since it used gcc instead of
ppc_82xx-gcc which caused error happen. I reinstalled the ELDK and not
help. So what could be the problem? Some configuration changes?

Best regards
Jack Liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
