Date: Wed, 20 Sep 2000 10:01:29 -0500 (CDT)
From: ian reinhart geiser <geiseri@msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Build problems with the latest BenH Rsync
Message-ID: <Pine.OSF.3.96.1000920100052.25487C-100000@torres.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,
        I cannot seem to get the latest Ben H kernel to build.
        I get the following error:
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O3
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring   -c -o keyboard.o keyboard.c
./mkmap.adb > keymap-mac.c
/bin/sh: ./mkmap.adb: Permission denied
make[3]: *** [keymap-mac.c] Error 126
make[3]: Leaving directory `/usr/src/linux/drivers/usb'
make[2]: *** [first_rule] Error 2

        Is this an issue with my rsync arguments?

        Thanks
        -ian reinhart geiser


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
