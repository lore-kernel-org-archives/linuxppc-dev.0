Return-Path: <a.korud@vector.com.pl>
Received: from 3bit.vector.com.pl (3bit.vector.com.pl [81.210.9.37])
	by ozlabs.org (Postfix) with ESMTP id 4F42967A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 19:04:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Date: Wed, 2 Mar 2005 08:51:18 +0100
Message-ID: <60E856FD577CC04BA3727AF4122D3F1611352D@3bit.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: "Zeighami, Roy" <roy.zeighami@hp.com>,
	<linuxppc-embedded@ozlabs.org>
Cc: "Bawany, M. Ali \(HPSL, Richardson/STT\)" <muhammad.bawany@hp.com>
Subject: RE: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
as I know there is no public available kernel tree with Bamboo support, =
you have to implement it yourself if you need it right now or just wait.
Please correct me if I'm wrong.

Best regards,

--

Andriy Korud


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org on behalf of Zeighami, Roy
Sent: Tue 3/1/2005 17:14
To: linuxppc-embedded@ozlabs.org
Cc: Bawany, M. Ali (HPSL, Richardson/STT)
Subject: Building a Kernel for the AMCC PPC440EP Bamboo Board
=20
Hello...

I am trying to build a kernel image for the AMCC Bamboo PPC440EP board.

My colleague downloaded a preview kit from MontaVista and that worked.

However, I am trying to build a toolchain using crosstool and create a
2.6.x kernel image.  However, when I type:

"make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-440-linux-gnu- menuconfig"

When I select 44x as the CPU type, I don't see "Bamboo" under machine
type. =20

Also, I tried building a 2.6.8 kernel image  with Ebony but I can't get
a successful build.

I get the following errors:

drivers/built-in.o(.text+0x3c7ec): In function
`floppy_release_irq_and_dma':
: undefined reference to `free_dma'
drivers/built-in.o(.text+0x3dc14): In function
`floppy_grab_irq_and_dma':
: undefined reference to `request_dma'
drivers/built-in.o(.text+0x3dddc): In function
`floppy_grab_irq_and_dma':
: undefined reference to `free_dma'
make: *** [.tmp_vmlinux1] Error 1

However, the crosstool web site says that the following combo should
build: gcc-3.4.2, glibc-2.3.3, binutils-2.15, linux-2.6.8

Any suggestions?

Also, if the kernel source provided by Monta Vista is some special
branch that isn't merged to kernel.org, does anyone know how to get the
latest source from Monta Vista?

Is one of these the version that I should be getting?

zeighami@linux-2.6.8  $ rsync source.mvista.com::
mol             Mac-On-Linux Source
libmol          Binary MOL Support Files
yaboot          Ethan's Yaboot Devel Tree
yaboot-benh     BenH's Experimental Yaboot Tree
linuxppc_2_4    LinuxPPC 2.4 BitKeeper tree, stable branch
linuxppc-2.4    "LinuxPPC branch of the official 2.4 BitKeeper tree"
linuxppc_2_4_benh       Ben's 2.4 Tree (aka, the PowerMac tree)
linuxppc_2_4_devel      LinuxPPC 2.4 BitKeeper tree, development branch
linuxppc-2.5    LinuxPPC 2.5 tree, based on Linus' BitKeeper tree
linuxppc-2.5-benh       Ben's 2.5 / 2.6 tree, based on the LinuxPPC 2.5
/ 2.6 tree.
linuxppc_2_2    LinuxPPC 2.2 BitKeeper tree

Thanks,

Roy
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
