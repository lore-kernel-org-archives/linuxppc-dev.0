Return-Path: <embeddedxilinx@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.200])
	by ozlabs.org (Postfix) with ESMTP id D75FF689F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 06:11:11 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id l8so329049nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 11:11:09 -0800 (PST)
Message-ID: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
Date: Mon, 30 Jan 2006 12:11:09 -0700
From: David Summers <embeddedxilinx@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Getting started with Xilinx V4 PPC?
MIME-Version: 1.0
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

I am starting a new project where I need to have a flash file system
and an ethenet interface (HTTP and FTP).  The project is a solar
physics experiment that will be launched on a sub-orbital rocket
flight this fall.  The idea is that the experiment will write data
files to the flash file system while in flight, and then I can
download the data using ethernet after the experiment returns to
earth.

I think that Linux is the way to go for this project because of the
JFFS2 filesystem and the strong networking support.  The only problem
is that I am totally new to embedded linux.

I am prototyping my system on an Avnet FX12 development board ( Specs
here: http://tinyurl.com/4gfdv ) which is pretty similar to the Xilinx
ML403 board except with less memory and no SystemACE slot.

I will eventually build my own custom board with the same Xilinx
Virtex 4 FX12 FPGA and additional flash memory and some custom
interface hardware. My background is primarily as a hardware designer,
and I am very confortable with the FPGA part of this project.   I am
comfortable as a Linux user, and I am a pretty good C coder (for a
hardware guy anyway :).  I have never built a linux system (embedded
or desktop) before, and I need some help getting started with embedded
linux.

I have already found the following websites which have been a big help so f=
ar:

http://www.klingauf.de/v2p/index.phtml
http://splish.ee.byu.edu/projects/LinuxFPGA/configuring.htm
http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html#toc=
1

I have a few questions that I hope someone can help me with:

1. What is the best linux distribution to start out with?  I am
currently working with the 2.4 kernel code from
ppc.bkbits.net/linuxppc_2_4_devel, but I'm not sure that this version
be being updated.  (MontaVista also seems to be making it rather
difficult to download their free Linux Preview Kit, so I wouldn't mind
finding another distribution)    Does the DENX distribution have good
PPC support?  Are there any others that I should look at, or should I
just download the kernel source directly from kernel.org?


2. kernel 2.4 or 2.6?

It is my understanding that the latest version of MTD and JFFS2 have
dropped support for kernel 2.4.  I would like to use JFFS2 on a NAND
flash device, so it seems like I should use 2.6.  (Can I use JFFS2 on
a NAND device with kernel v 2.4?)

Being a complete newbie, am I biting off more that I can handle by
trying to use 2.6?

I have been lurking on the mailing list for a while, and I know that
there are several people working on 2.6.x patches for the Xilinx
virtex 4 parts.  Could someone point me to a list of the patches that
I need to get me started?  I think that the ML403 patches should work
with my board, but I don't know which ones I need to download.


Thank you for your help,

David Summers
University of Colorado
