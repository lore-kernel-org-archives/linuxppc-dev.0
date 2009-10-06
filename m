Return-Path: <thomas.rinder@automationtechnology.de>
From: "Thomas Rinder" <thomas.rinder@automationtechnology.de>
To: <Linuxppc-dev@lists.ozlabs.org>
References: <1253783426-11978-1-git-send-email-vivek.mahajan@freescale.com>	<1253783426-11978-2-git-send-email-vivek.mahajan@freescale.com>	<1253783426-11978-3-git-send-email-vivek.mahajan@freescale.com>	<1253783426-11978-4-git-send-email-vivek.mahajan@freescale.com>	<49156378-9156-4059-99C2-57E2815473BD@freescale.com>	<F2F605B667B24B489C904986E0D60A08FF6268@zin33exm23.fsl.freescale.net>
	<6D81C181-23BF-4FA7-B016-779919D61957@freescale.com>
In-Reply-To: <6D81C181-23BF-4FA7-B016-779919D61957@freescale.com>
Subject: XILINX  memory layout <-> physical memory
Date: Tue, 6 Oct 2009 10:06:18 +0100
Message-ID: <001201ca4664$4529ed50$cf7dc7f0$@rinder@automationtechnology.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm newbie in PPCLinux, don't know I'm right here.

I made a ports to an AVNET FX12 minimodul and custom board (FX40/FX60) based
on linuxppc found on http://git.xilinx.com/ (ppc405 processor).

All works fine, but I can use/configure only the half memory size available
in the dts (for instance 32Mbytes of 64Mbytes on Avnet minimodul).
Otherwise the kernel crashes if tries to mount the root file system (ext2
ramdisk).

I expect my problem is the physical memory layout and its control. I want to
understand and control the physical memory layout.

But I didn't not found documentation how the memory layout is organized in
linuxppc and
how do I control were kernel, ramdisk etc. resides in physical memory.

Could anyone give me a hint please, how-to start?

Thanks a lot,

Thomas

Ausgehende eMail ist virenfrei.
Von AVG uberpruft - www.avg.de 
Version: 8.5.420 / Virendatenbank: 270.14.4/2416 - Ausgabedatum: 10/05/09
18:23:00 
