From: "Georg Klug" <gklug@giga-stream.de>
To: "Jis Joy" <jisjoy@procsys.com>,
	"Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: Booting Linux on Custom PowerPC 405GP board
Date: Fri, 5 Jul 2002 10:25:46 +0200
Message-ID: <FFECLICFNBJAHONLGAKMCEDHCFAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3D252776.60ACBA64@procsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jis,

> We got a custom PowerPC 405GP board, we want to boot Linux on that.
>
> Board limitations are:
> 1. There is no network interface, only serial port. The kernel image has
>
> to be  downloaded through the serial port. (network interface will be
> added
> to this card in future.)
> 2. The monitor code is also custom one, its no a Walnut ROM monitor.

Did you think about using PPCBOOT? This works really perfect with the Linux
kernel.

> I found out that the boot loader files are in
> /src/linux/arch/ppc/boot/tree directory (Am I  correct ??).
> What are the changes I have to make to boot linux.

The code from that standard kernel directory is only packaged arounfd the real
kernel
vmlinux.
Even if you don't want to use PPCBOOT, read its documentation. Then you get
good information on how the booting works.

> Will it start booting, if I download the
> /src/linux/arch/ppc/boot/image/vmlinux to the 0x00000000 location and
> jump to that location ?? (the image is compiled for 405GP processor).

Very unlikely, if you custom monitor was not designed for that. Some low level
initializations are not done in the kernel. Again the documentation of PPCBOOT
would give you a hint on what is possibly missing.

Georg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
