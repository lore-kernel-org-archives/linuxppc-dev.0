Return-Path: <manuel.pezzin@free.fr>
Message-ID: <471FA48B.2020809@free.fr>
Date: Wed, 24 Oct 2007 22:01:15 +0200
From: manu <manuel.pezzin@free.fr>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: problems to boot 2.6.23 kernel on XILINX ppc with 8Mbytes of RAM
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I work on a custom board based on a virtex 2 pro FPGA and 8Mbytes of SDRAM.
Untill now I used a 2.4.31 linux ppc kernel with John Williams patches
and uclinux distribution and everything worked perfectly.
I've decided to move to the latest 2.6 version from kernel.org
(2.6.23.1) with an initramfs containing a busybox.
My complete zImage including the initramfs has a size of 900Kbytes.
I made some tests with a ML300 board and I managed to get a shell easily.
When I migrated to the custom board, I had the "Now booting the kernel"
message and then nothing.
When I trace the code running on the ppc with the debugger, execution
seems to be stuck in some early initialization code.
I managed to reproduce the problem on the ML300 using "mem=8m" parameter
on the bootline.
With "mem=16m" the kernel boots correctly.
I'm really surprised by the amount of RAM required to boot the kernel.
Is there a way to make it boot with only 8Mbytes of RAM ?
Thanks for your help.

Manu
