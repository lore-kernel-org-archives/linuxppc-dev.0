Message-ID: <89DEFCC5DB33D411A27F00508BCF8A820A8D5A14@ZCH07EXM05.corp.mot.com>
From: Liu Fred-a18596 <fred.liu@motorola.com>
To: BREUVART Jean-Charles <jean-charles.breuvart@airbus.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: pb compiling cross gcc, binutils, glibc and so on ...
Date: Fri, 20 Dec 2002 09:57:40 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 5. build gcc core 2.95.3 for powerpc cross compile, and install it in
> /opt/powerpc-linux/ :
>       - cd /usr/src/gcc-2.95.3/
>       - make clean
>       - make distclean
>       - CC=/usr/local/bin/gcc ./configure --target=powerpc-linux
> --enable-shared --enable-languages=c --with-newlib
> --prefix=/opt/powerpc-linux
>       - add /opt/powerpc-linux at the end of $PATH, otherwise
> make doesn't
> find powerpc-linux-as, powerpc-linux-ld and so on
>       - make
>
> Here is the trouble :
>
> choose-temp.c:29: stdio.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:30: sys/types.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:32: unistd.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:35: stdlib.h: Aucun fichier ou r?pertoire de ce type
> choose-temp.c:38: sys/file.h: Aucun fichier ou r?pertoire de ce type
>
> there aren't any of those in /opt/powerpc-linux/ or its subdirs
>
It's true that there are no any of those files. They are in glibc which you have not compiled yet.
Some useful tips at: http://www.mock.com/receiver/tools/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
