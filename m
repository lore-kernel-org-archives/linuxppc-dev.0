Date: Fri, 3 Aug 2001 11:46:08 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] IBM PReP power down
Message-ID: <20010803114608.A9987@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch allows IBM PReP machines to power down (instead of 'while (1);') on
poweroff. It works on 7248-43P, and should work on the other Carolina
machines: 6070 and 6050 (which are still having serious i8259 problems).
Because all the older IBM systems seem to have an identical power management
system, it should also work on the 7043-140 (Tiger 1) in PReP mode and
probably most other IBM PReP machines.

The patch is against _2_4, but applies with slight offsets to _2_4_devel as
well. Please commit to both?

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
