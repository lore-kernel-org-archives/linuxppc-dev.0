Message-ID: <3B97CA7E.6010805@brocade.com>
Date: Thu, 06 Sep 2001 12:11:58 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: =?x-windows-949?B?wLG1v7yu?= <manulsan@daintelecom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to make ramdisk ?
References: <002801c1346a$553b1e40$2000a8c0@private>
Content-Type: text/plain; charset=x-windows-949
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Look at Documentation/ramdisk.txt in the kernel source tree for details.

Amit


윤동석 wrote:
> 네트워크Hi
>
> I'am trying to Hard Hat linux 1.2  on custom MPC8240 Board
> modifying  Sandpointing8240  SDK.
> I want to use ramdisk  so I did " make  zImage.initrd"
> but there are errors.  followings are error messages
> =================================================================
> .
> .
> mlinux:                 59.5% -- replaced with vmlinux.gz
> make[2]: Leaving directory `/opt/hardhat/devkit/lsp/motorola-sandpoint/linux-2.4.2_hhl20/arch/ppc/boot/images'
> make -C sandpoint zImage.initrd
> make[2]: Entering directory `/opt/hardhat/devkit/lsp/motorola-sandpoint/linux-2.4.2_hhl20/arch/ppc/boot/sandpoint'
> ppc_82xx-ld -T /opt/hardhat/devkit/lsp/motorola-sandpoint/linux-2.4.2_hhl20/arch/ppc/vmlinux.lds -Ttext 0x00800000 -o zvmlinux.initrd.tmp head.o ../common/misc-common.o ../common/misc-simple.o ../common/ns16550.o ../common/string.o ../lib/zlib.a
> ppc_82xx-objcopy -O elf32-powerpc -R .comment \
>         --add-section=initrd=../images/ramdisk.image.gz \
>         --add-section=image=../images/vmlinux.gz \
>         zvmlinux.initrd.tmp zvmlinux.initrd
> ppc_82xx-objcopy: cannot stat: ../images/ramdisk.image.gz:  no such file or directory
> make[2]: *** [zvmlinux.initrd] Error 1
> make[2]: Leaving directory `/opt/hardhat/devkit/lsp/motorola-sandpoint/linux-2.4.2_hhl20/arch/ppc/boot/sandpoint'
> make[1]: *** [zImage.initrd] Error 2
> make[1]: Leaving directory `/opt/hardhat/devkit/lsp/motorola-sandpoint/linux-2.4.2_hhl20/arch/ppc/boot'
> make: *** [zImage.initrd] Error 2
> =================================================================
>
> Question ]
>     At cimpile time, ramdisk.image.gz is needed .
>
>    1) How do I make ramdisk.image.gz ?
>
>
> Thanks in advance.
>                                                 DongSeak Yoon
>
> Question ]
>
>    1) Do I have to make ramdisk.image.gz ?
>    2) if so , how can I make it  ?
>
>
> Thanks in advance.
>                                                 DongSeak Yoon
>
>
>
>
> E-mail  : manulsan@daintelecom.com
> Mobil   : 016-208-9568
> Fax     : 82-2-581-2805
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
