Message-Id: <6.0.2.0.0.20040204170854.01ebeec0@corelis.com>
Date: Wed, 04 Feb 2004 17:13:26 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: ppc405 and PCI bus state
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I have questions about internal PCI bus controller of ppc405gp process.
Our custom board currently does not use the PCI and want it to be in a
parked state. According to the data sheet, ppc405gp needs pull up resisters
if the PCI controller on the processor is not parked in proper state.

Does linux automatically put it in a park state if PCI supported is not
configured?
If not, what do I have to do to park it?

We like to avoid putting on large number of pull up resister if possible.

Thank you.


===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x132
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
