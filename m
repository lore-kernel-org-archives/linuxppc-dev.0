Return-Path: <mgaouar@solacom.com>
Received: from solacom.com (unknown [209.217.64.195])
	by ozlabs.org (Postfix) with ESMTP id D8EFCDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 02:38:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Problems compiling Linux for MPC8272ADS
Date: Mon, 24 Sep 2007 12:26:24 -0400
Message-ID: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
From: "Manil Gaouar" <mgaouar@solacom.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there,

I am trying to compile the latest Linux from the git repos: git clone
git://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx, I checked out
the code a few weeks ago and was able to build my uImage no problems. I
did a git pull this morning and I can not compile anymore, here is the
error message I have:

  BOOTCC  arch/powerpc/boot/ps3.o
  BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
  BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
  BOOTCC  arch/powerpc/boot/treeboot-walnut.o
{standard input}: Assembler messages:
{standard input}:184: Error: Unrecognized opcode: `mfdcr'
{standard input}:185: Error: Unrecognized opcode: `mfdcr'
{standard input}:186: Error: Unrecognized opcode: `mfdcr'
{standard input}:217: Error: Unrecognized opcode: `mtdcr'
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
make: *** [uImage] Error 2

here are the commands I am using:

make mrproper
make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- mpc8272_ads_defconfig
make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage

Do you have any ideas, or I should check out the 2.6.22 stable release
instead and try again???

Thx
