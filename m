Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 02 Apr 2004 12:34:56 -0500
From: Jeff Tucker <jeff@jltnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Need help booting linux on IBM 405EP eval board
Message-ID: <1866383.1080909296@[192.168.0.230]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, guys.

I sent a message like this to the U-Boot mailing list last night. I've been
told this is definitely not a U-Boot problem, so I'm hoping that the people
on this list can help me.

I'm having a hard time getting U-Boot to boot Linux on an IBM 405EP
evaluation board. Here's what I've tried:

First, I think my kernels are fine. I can compile 2.4.18 from an older
version of the ELDK or I can compile 2.4.24 from the latest released ELDK.
I'm using ELDK tools for all of my builds. Using the IBM bootloader that
comes on the board and the "treeboot" image file format, I can get the IBM
board to tftp my kernel over the lan and run it. So, I think the kernel is
working fine.

I also don't have any problem running U-Boot. I compiled 1.0.2 and
installed it on the board. U-Boot runs fine and I can make it tftp a file
over the network as well. Using iminfo, I can see that it read what I
expect. However, no matter what I try, I can't get the kernel to actually
boot.

In the older kernel, I'm using a "make pImage" and in the newer kernel I do
"make uImage". I've also tried running the mkimage tool manually with
various options to see if I could get a kernel to boot. iminfo says the
kernel is fine and I get to the "Uncompressing Linux Kernel ... OK" stage
but it stops there.

I'm aware that the denx.de site has a FAQ which appears to address this
issue:
<http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel>

However, the structure mentioned there (bd_info) doesn't even seem to apply
for a 405EP-based board. The ppcboot.h file isn't included by the files
used when building a 405EP kernel for the 405EP evaluation board.

It still could be a problem passing parameters to the kernel, I suppose,
but I am not sure how those are defined in the first place.

I searched the mailing list archives but couldn't find anyone who had a
similar problem. So, if someone is using U-Boot to boot a kernel on the
405EP evaluation board would be willing to give me some pointers, I'd
appreciate it.

Thanks
Jeff



--
Jeff Tucker
jeff@jltnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
