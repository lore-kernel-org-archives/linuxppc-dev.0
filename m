Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 18 Apr 2001 15:45:46 -0300
From: Marcio Koch <koch@inf.pucrs.br>
To: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Intel Flash
Message-ID: <20010418154546.C6248@sirrah.inf.pucrs.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Intel
TE28F320
B3BA110
U9490626A
(c)1998

Does anybody know if this flash is supported by linux ? If so what kernel
and mtd code should I use ?

For MPC8xx.

I'm using kernel 2.4.3-pre4 and it fails when I try to load the physmap
module.

Here is what I did and the error I got:

sh-2.03# modprobe -a mtdchar mtdblock cfi_cmdset_0001  map_rom cfi_probe
sh-2.03# lsmod
Module                  Size  Used by
cfi_probe               7920   0  (unused)
map_rom                 1072   0  (unused)
cfi_cmdset_0001         8000   0  (unused)
mtdblock                6528   0  (unused)
mtdchar                 5408   0  (unused)
mtdcore                 2976   2  [mtdblock mtdchar]
sh-2.03# modprobe -a physmap
physmap flash device: 3fffff at fe000000
Physically mapped flash: Found no CFI device at location zero
/lib/modules/2.4.3-pre4/kernel/drivers/mtd/physmap.o: init_module: Device
not configured
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters
/lib/modules/2.4.3-pre4/kernel/drivers/mtd/physmap.o: insmod
/lib/modules/2.4.3-pre4/kernel/drivers/mtd/physmap.o failed
/lib/modules/2.4.3-pre4/kernel/drivers/mtd/physmap.o: insmod physmap failed


Any help would be appreciated.

Thanks,

Marcio Koch
koch@inf.pucrs.br
PUCRS/ELinux


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
