Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Fri, 17 Jan 2003 13:27:33 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux PowerPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: how to hardcode ramdisk parameters in kernel
Message-ID: <20030117112733.GA16093@oasis.frogfoot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

Is there any way to hardcode the parameters in the kernel so that it loads
the ramdisk at runtime correctly. For example:

kernel -> zImage.bin
ramdisk -> ramdisk.gz

Now I want to do

cat zImage.bin ramdisk.gz > boot.bin

and then I want to write initrd_start (size of zImage.bin) and initrd_end
(initrd_start+size of ramdisk.gz) somewhere in the boot.bin binary and the
kernel should know where to find the ramdisk in memory at boot time.

I'm using the simple boot loader for my platform. From the sandpoint
platform code it seems that r4 and r5 is passed to the platform_init()
function and that can be used to setup initrd_start and initrd_end
correctly, but how do I set r4 and r5?

--

Regards
 Abraham

QOTD:
	"I ain't broke, but I'm badly bent."

___________________________________________________
 Abraham vd Merwe [ZR1BBQ] - Frogfoot Networks
 P.O. Box 3472, Matieland, Stellenbosch, 7602
 Cell: +27 82 565 4451 Http: http://www.frogfoot.net/
 Email: abz@frogfoot.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
