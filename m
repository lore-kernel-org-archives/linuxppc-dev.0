Message-ID: <38281D7F.CC9914C@snom.de>
Date: Tue, 09 Nov 1999 14:11:27 +0100
From: Nicolas Pohland <pohland@snom.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: devel@gate.crashing.org
Subject: MMU Initialization Problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hi Mark,

I have the same problem on a FADS board and 2.3.10. I do not have a
solution yet, but maybe able to describe the
problem in more detail.


I can unzip the kernel at location 0 and then this space is mapped to
0xc0000000 in 1 8Mb page.
Then the start_here routine and in it the MMU_init function called.

This is what I found strange:

a. The level 1 descriptors in the table are made up of effective
addresses (or virtual) and
NOT of physical addresses. 

b. The valid bit (LSB) of the descriptor is not set to 1.

Have I missed something here ?

Ciao,
Nicolas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
