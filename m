From: deepesh@india.tejasnetworks.com
Message-ID: <1057227367.3f0402676dddd@pop-mail.india.tejasnetworks.com>
Date: Thu, Thu 03 Jul 2003 03:46:07 PM IST, Jul 2003 15:46:07 +0530
To: wd@denx.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: EP8260
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

  I am having an EP8260 Board. The board comes with a PlanetCore BootLoader
and a diagnostics. I want to boot kernel using this bootloader. TimeSys
people claim to have released a kernel binary for EP8260. I am not able to
boot this kernel. What is clear is that the board info structure is passed
correctly from the planetcore boot loader to the kernel arch/ppc/boot/.
This is because I found that the decompress_kernel function is working. I
dumped the first few bytes of memory, starting at 0(zero). They are exactly
same as the "dissembled vmlinux".

   But there is a problem in entering from the arch/ppc/boot code to
arch/ppc/kernel code. The board goes for a reset.

Kindly help.

Please  give me a reference to a kernel which would come up with this
bootloader(PlanetCore)

Thank you,
Deepesh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
