Return-Path: <prabha.j@tcs.com>
Received: from INKOLG01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id E6BC66872B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 23:20:05 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: prabha.j@tcs.com
Message-ID: <OFF101A064.257D1AD3-ON652570BC.0020DC73-652570BC.002126C8@tcs.com>
Date: Thu, 17 Nov 2005 11:32:06 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 0021269F652570BC_="
Subject: help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0021269F652570BC_=
Content-Type: text/plain; charset="US-ASCII"


Hi all,
I am trying to build kernel image for my custom borad which is similar to 
mpc8260ads board. But i am getting the error.

I am using denx enldk and also the kernel source.

The error is
 make[1]: Entering directory 
`/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'
make all_targets
make[2]: Entering directory 
`/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory 
`/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'
make[1]: Leaving directory 
`/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'
ppc_6xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic 
arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o 
arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o 
ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/pci/driver.o drivers/mtd/mtdlink.o 
drivers/macintosh/macintosh.o drivers/media/media.o \
        net/network.o \
        /home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o(__ksymtab+0x480): In function `sys_call_table':
arch/ppc/kernel/entry.S: undefined reference to `__res'
make: *** [vmlinux] Error 1

Thanks in advance

Prabha J.
Tata Consultancy Services Limited
Mailto: prabha.j@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you
--=_alternative 0021269F652570BC_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi all,</font>
<br><font size=2 face="sans-serif">I am trying to build kernel image for
my custom borad which is similar to mpc8260ads board. But i am getting
the error.</font>
<br>
<br><font size=2 face="sans-serif">I am using denx enldk and also the kernel
source.</font>
<br>
<br><font size=2 face="sans-serif">The error is</font>
<br><font size=2 face="sans-serif">&nbsp;make[1]: Entering directory `/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'</font>
<br><font size=2 face="sans-serif">make all_targets</font>
<br><font size=2 face="sans-serif">make[2]: Entering directory `/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'</font>
<br><font size=2 face="sans-serif">make[2]: Nothing to be done for `all_targets'.</font>
<br><font size=2 face="sans-serif">make[2]: Leaving directory `/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'</font>
<br><font size=2 face="sans-serif">make[1]: Leaving directory `/home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/arch/ppc/lib'</font>
<br><font size=2 face="sans-serif">ppc_6xx-ld -T arch/ppc/vmlinux.lds -Ttext
0xc0000000 -Bstatic arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o init/main.o
init/version.o init/do_mounts.o \</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; --start-group
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; arch/ppc/kernel/kernel.o
arch/ppc/platforms/platform.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/pci/driver.o
drivers/mtd/mtdlink.o drivers/macintosh/macintosh.o drivers/media/media.o
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; net/network.o
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; /home/cdot/eldk/ppc_6xx/usr/src/linux-2.4.25/lib/lib.a
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; --end-group
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; -o vmlinux</font>
<br><font size=2 face="sans-serif">arch/ppc/kernel/kernel.o(__ksymtab+0x480):
In function `sys_call_table':</font>
<br><font size=2 face="sans-serif">arch/ppc/kernel/entry.S: undefined reference
to `__res'</font>
<br><font size=2 face="sans-serif">make: *** [vmlinux] Error 1</font>
<br>
<br><font size=2 face="sans-serif">Thanks in advance</font>
<br><font size=2 face="sans-serif"><br>
Prabha J.<br>
Tata Consultancy Services Limited<br>
Mailto: prabha.j@tcs.com<br>
Website: http://www.tcs.com</font>
<table><tr><td bgcolor=#ffffff><font color=#000000>Notice: The information contained in this e-mail message and/or attachments to it may contain confidential or privileged information.   If you are not the intended recipient, any dissemination, use, review, distribution, printing or copying of the information contained in this e-mail message and/or attachments to it are strictly prohibited.   If you have received this communication in error, please notify us by reply e-mail or telephone and immediately and permanently delete the message and any attachments.  Thank you<br>
</font></td></tr></table>
--=_alternative 0021269F652570BC_=--
