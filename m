Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <priyadk@future.futsoft.com>
From: "Priyadarshini K" <priyadk@future.futsoft.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Rpxlite Booting
Date: Tue, 20 Aug 2002 19:37:53 +0530
Message-Id: <000501c24852$fa3e4be0$1106140a@future.futsoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
   I am trying to recompile the Hardhat kernel for Embedded Planet rpxlite
board and boot the target. But I have problems.

   I want these details:

   1) Are there any specific options I need to set/change while compiling
the Hardhat kernel (with menuconfig or the compiler options)?
      One of the compiler options is mcpu=860. The Rpxlite board is based on
MPC823e. Should the mcpu option be changed for it?

   2) What is the bfdformat of the image expected by the rpxlite board?
Should I build the kernel image in S record format?

   3) If so can I compress the image using gzip? Should the compression be
done before mkimage or after mkimage?

   Can anyone help me with these?

   Right now, I am doing the following:

   ppc_8xx-objcopy -S -O binary vmlinux vmlinux-raw
   gzip vf9 vmlinux-raw
   ./mkimage -n 'Linux RpxLite' -A ppc -O linux -T kernel -C gzip -d
vmlinux-raw.gz rpxlite-image

   I am able to tftp the rpxlite-image onto the target. But I cannot run the
image on the target. Is there anything wrong with the options I am using?

   Thanks in advance for any help

   Regards
   Priya


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
