Message-ID: <00a101c40291$c31a7120$0400a8c0@portatile>
Reply-To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <20040304110742.949A1C0655@atlas.denx.de>
Subject: Re: "mkimage" not found 
Date: Fri, 5 Mar 2004 10:10:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang

> Maybe your PATH ist not correct?

You are perfectly right! I didn't add the line "export
PATH=$PATH:/opt/eldk/usr/bin"  to .bashrc.
Many thanks

> > With the previous ELDK2.0 I would have generated the image with the
"make
> > pImage" command while now I suppose the command "make uImage" must be
used.
> > Is this correct?
>
> This is correct, but "make pImage" will still work, too.

unfortunately I had the following messages:

[gianfranco@home001 linux]$ make pImage
make: *** No rule to make target `pImage'.  Stop.
[gianfranco@home001 linux]$ grep -r pImage *
arch/ppc/boot/Makefile:pImage: $(MKIMAGE) images/vmlinux.gz
[gianfranco@home001 linux]$ grep -r uImage *
arch/ppc/boot/Makefile:uImage  \
arch/ppc/boot/Makefile: ln -sf vmlinux.UBoot images/uImage
arch/ppc/Makefile:BOOT_TARGETS = zImage zImage.initrd znetboot
znetboot.initrd uImage
CHANGELOG:Add support for U-Boot boot image "uImage"
[gianfranco@home001 linux]$


Should I modify BOOT_TARGET into arch/ppc/Makefile?

Best regards
Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
