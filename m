From: Ruedi.Hofer@ascom.ch
Date: Tue, 03 Oct 2000 11:37:51 +0100 (CED)
Subject: Antwort: Re: Kernel 2.4.0 test8
To: diekema@bucks.si.com
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1U0014BLFN06@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_tbLb9PcHbczutVnl8CMbRw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_tbLb9PcHbczutVnl8CMbRw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Jon

I downloaded the kernel 2.4.0-test8 from linux.org and decompressed it. Then I tried to run
make menuconfig after having changed the Makefile for ppc.

After I've saved the config I noticed that CONFIG_8260 was not set. I changed that manually
to correspond to the HHL1.2 kernel config.

Then:

>make symlinks
>make dep && make clean && make zImage
> ......
>/usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/asm/processor.h:724: #error "Machine not defined correctly"
>In file included from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/capability.h:17,
>                 from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/binfmts.h:5,
>                 from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/sched.h:9,
>                 from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/mm.h:4,
>                 from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/slab.h:15,
>                 from /usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/malloc.h:4,
>                 from init/main.c:15:
>/usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/fs.h:547: warning: `struct flock64' declared inside parameter list
>/usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/fs.h:547: warning: its scope is only this definition or declaration,
which is probably not what you want.
>/usr/src/eld/products/sbc8260/kernel/hardhat/linux-2.4.0-test8/include/linux/fs.h:548: warning: `struct flock64' declared inside parameter list
>make: *** [init/main.o] Error 1

... hmmm?

How do you set the configuration?

Do you mind sending me your .config file?

(I even tried to copy the .config file from HHL1.2 without success!)

\Ruedi






diekema@bucks.si.com on 02.10.2000 16:50:30
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:
Thema: Re: Kernel 2.4.0 test8

> Is the 2.4.0-test8 kernel from http://www.kernel.org as up to date as
> the one is from fsmlabs?

The latest on FSMLabs is 2.4.0-test9-pre6.  I would try using
2.4.0-test8 from http://www.kernel.org, and see how it goes.





--Boundary_(ID_tbLb9PcHbczutVnl8CMbRw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
