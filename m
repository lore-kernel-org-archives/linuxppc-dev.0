From: Michael Silva <msilva@lynx.dac.neu.edu>
Message-Id: <200308281429.KAA0000026986@lynx.dac.neu.edu>
Subject: Booting Linux with Dink
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 28 Aug 2003 10:29:35 -0400 (EDT)
Reply-To: msilva@lynx.neu.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Background:
I am trying to load a linux kernel build onto a Motorola Yellowknife
evaluation board.

So far:
I have built the toolchain and a kernel (2.4.18 w/ ppc patches) based on
the instructions in Mr. Yaghmour's book "Building Embedded Linux
Systems".  So far, things have gone well.
The Yellowknife board I have is currently running the Dink32 boot
rom/monitor.

Issues:
- I tried running the kernel from the dink monitor.  (I downloaded the
kernel via srecords, and basically typed 'go' at the kernel's start
address).  It didn't work.  So, I started tracing the code and I soon
discovered that the kernel seems to be expecting certain pieces of
information from the boot rom (sorry, I'm a newbie at kernel internals).
 So, is there any way to get the kernel to boot from the dink boot rom?

- Based on the above, I was thinking of loading U-boot onto the board
(instead of dink).  Has anyone gotten U-boot to support Yellowknife?  I
looked at the docs for U-boot, but could find no reference to it.

- Does anyone know of any references that document how to get Linux
running on a Motorola Yellowknife board?

I also could find no useful information on either issue above via google
searches.

Any help would be appreciated.

Thanks,
Mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
