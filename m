Message-Id: <5.1.1.6.2.20030611171936.012e0c68@corelis.com>
Date: Wed, 11 Jun 2003 17:28:02 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: writing device driver for memory mapped device
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
I have successfully booted Linux and u-Boot on our custom target (based on
IBM Walnut demo board) and I'm ready to start writing device driver for
Linux so that I can access my hardware on the board.

Our custom board has FPGA connected to EBC bus of PPC405gp and is memory
mapped. So, I only need a device driver which will allow me to map the
memory to the user space application and handle some interrupts. Can any
one recommend a good starting point?

Also, what are we required to do to stay compliant with GPL? Is posting
tarball of modified Linux/u-boot source on the web enough?

Any help will be appreciated.

Thank you.


===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
