Message-Id: <4.3.2.7.0.20000824132843.00b1f9a0@10.0.0.2>
Date: Thu, 24 Jul 2000 13:36:02 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Mike Coy <coym@embeddedplanet.com>
Subject: flash filesystem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've noticed that the size of my initrd is limited not by the size of my
flash, but by the amount of ram I have to decompress it into.
I would like to put a filesystem in the unused portion of my flash and read
it (read-only) without first copying it into ram.
I'm not entirely sure how to get at this filesystem, though.  The only way
I've seen flash accessed is with the initrd at boottime.
Has anyone done this?

The best that I can come up with is that the flash is probably mapped into
memory somewhere, and maybe I could fool the ramdisk code into reading a
pre-existant ramdisk at a given address.  This didn't appear to be too
trivial at my first browse through the code, though.
What is the right way to get at data in flash?

Thanks,
Mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
