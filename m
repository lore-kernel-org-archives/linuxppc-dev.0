Message-ID: <005201bfb0ca$c075ef20$bf0102c8@dell191.sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: the problem with kernel format
Date: Fri, 28 Apr 2000 05:32:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,
I encountered a big problem on the format of kernel file format.
the condition follows:
My host is x86--linux,and the target is ppc823-linux.
I have used my own cross-toolset to construct my kernel file,
including vmlinux , zImage(zvmlinux),zvmlinux.initrd, etc..
I want to debug such kernel file on my host through BDM,
which is EST of  visionPROBE. EST requres the format of
the kernel file is BIN , BDX,S,and Hex, but the kernel I got
from the cross-toolset is ELF. There comes the big problem:
How I can translate the ELF to BIN( BDX...)????????
By the way, the visionPROBE provides a converter , which can
only translate the usual ELF to BIN(BDX).
But the kernel file is a compressed one(including vmlinux,bootloader,
and other initializing code).So the converter can't translate the compressed
one to BIN(BDX).
Has anyone encountered such a problem?
How to address it ?

Thanks a lot !!!!!!!!!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
