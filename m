Subject: Question about linker -Ttext option
From: Bob Beck <beck@assurtech.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1078791026.4208.9.camel@budweiser>
Mime-Version: 1.0
Date: 09 Mar 2004 14:10:26 +1400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In the arch/ppc/boot directory, one of the linker
options is "-Ttext 0x00800000".


What does this mean ?

The base virtual address of the kernel is c0000000.

I've been using my own hand-rolled bootloader to
load the zImage.bin file into an address allocated
by the VxWorks malloc and jumping to that address.

Second question.

arch/ppc/boot/simple/head.S says it expects the load address
in r3. It seems strange that it would need its own (start)
starting address. What is this routine expecting ?


Regards,
Bob Beck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
