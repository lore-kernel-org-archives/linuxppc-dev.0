From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: -Ttext  for Kernel
Date: Mon, 3 Jul 2000 21:08:26 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJGENHCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <003701bfe3b2$65435aa0$1952df8d@SOYANG>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Successfully, I decompressed the kernel, and after decompress_kernel fuction, the instruction pointer is changed to 0x0000 000c, the start point of decompressed kernel.

But, after that machine check exception is appeared, because IP is 0xc000 XXXX. (which I do not use.)

I saw the makefile then I found that one of the link options for the kernel is '-Ttext 0xc000 0000'.

I know it means linker links the objects from address 0xc000 0000. I think it should be 0x0000 0000, because the kernel is decompressed from address 0x0000 0000 and the headers are used exception handler (e.g. 0x100 is used for reset)

Should I change the address to 0x0000 0000 or do something else?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
