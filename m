Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E62DBC698514D511A1AC0003470C1314EE2BF3@exchange.mvis.com>
From: Keith Outwater <Keith_Outwater@mvis.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Recommendations for LXT971A PHY MII interrupt connection
Date: Fri, 21 Dec 2001 08:45:00 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all -

I'm a hardware designer seeking to provide support on a custom MPC860T based
design for linux.
Does anyone have specific recommendations as to the best way to connect an
Ethernet PHY's MII
management I/F interrupt to the processor?  I'm using an Intel LXT971A PHY.

For example, are the general purpose external interrupts on IRQ[0:6] or the
CPM interrupts on port C preferred?
Is there a specific pin or interrupt that is preferred?

Thanks!

PS: (this is a bit off topic linux-wise, but related:  Wolfgang, what's the
preferred method as far a ppcboot is concerned?)


Keith Outwater
Sr. Electrical Engineer
Microvision, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
