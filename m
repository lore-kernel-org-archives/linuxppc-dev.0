From: BOAS@de.ibm.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <C12569F0.0007F7C1.00@d12mta05.de.ibm.com>
Date: Sat, 10 Feb 2001 20:25:11 -0500
Subject: Re: Little Endian to Big Endian
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Naushit,

>I am in need to write most efficint little endian
>to big endian conversion function.
>I know it can be done best in assembly with one instruction.
>can somebody tell me what instruction will do that?

Maybe you want to got to linux/inlcude/asm-ppc/byteorder.h
in the kernel source and take a loot at the __arch__swab

Boas Betzler, IBM Linux Technology Center
embedded Linux


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
