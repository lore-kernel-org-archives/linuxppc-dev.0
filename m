Date: Tue, 4 Sep 2001 17:38:06 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: can't compile linuxppc_2_4_devel for 405gp
Message-ID: <Pine.LNX.4.30.0109041733050.15177-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to compile the kernel for some 405gp's we have here, and the
make seems to fail at/near the last step.

I'm using a working .config from our 2.4.6 version. The only changes I
made to the new kernel were to change the Makefile to set ARCH = ppc and to
point CROSS_COMPILE at our cross compiler which is hhl 2.0.

Here is the last bit of the error:

/opt/hardhat/devkit/ppc/405/bin/ppc_405-objcopy -O elf32-powerpc -R
.comment \
	--add-section=image=../images/vmlinux.gz \
	zvmlinux.tmp zvmlinux
rm -f zvmlinux.tmp
../utils/mktree zvmlinux ../images/zImage.treeboot
zvmlinux is not an ELF image
make[2]: *** [zImage-TREE] Error 4
make[2]: Leaving directory `/local/home/jtyner/linuxppc_2_4_devel/arch/ppc/boot/simple'
make[1]: *** [zImage] Error 2
make[1]: Leaving directory `/local/home/jtyner/linuxppc_2_4_devel/arch/ppc/boot'
make: *** [zImage] Error 2

Any help is appreciated. Thanks.

--
John Tyner
jtyner@cs.ucr.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
