Message-ID: <39C9118F.A80FB79B@wanadoo.fr>
Date: Wed, 20 Sep 2000 21:35:43 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: ian reinhart geiser <geiseri@msoe.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Build problems with the latest BenH Rsync
References: <Pine.OSF.3.96.1000920100052.25487C-100000@torres.msoe.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian reinhart geiser wrote:
>
> Greetings,
>         I cannot seem to get the latest Ben H kernel to build.
>         I get the following error:
> cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O3
> -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
> -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
> -mstring   -c -o keyboard.o keyboard.c
> ./mkmap.adb > keymap-mac.c
> /bin/sh: ./mkmap.adb: Permission denied
> make[3]: *** [keymap-mac.c] Error 126
> make[3]: Leaving directory `/usr/src/linux/drivers/usb'
> make[2]: *** [first_rule] Error 2
>
>         Is this an issue with my rsync arguments?

This used to be an issue with the usb files (namely that the script
mkmap.adb didn't have the x bit set), but this hasn't existed for quite
a while in BenH's tree. You must have an old drivers/usb/Makefile and
also the obsolete mkmap.adb script.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
