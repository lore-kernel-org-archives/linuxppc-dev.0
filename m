Message-Id: <l03130303b51671946984@[216.164.128.178]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 9 Apr 2000 13:45:37 -0400
To: linuxppc-dev@lists.linuxppc.org
From: "DeRobertis" <derobert@erols.com>
Subject: External clocking a serial port?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To run a Mac serial port at 1.8Mbps like the Epson Stylus Color 740's
docs say it can, you need external clocking.

I'm guessing the Stylus Color 740 is sending out the proper clock to do
so -- and no doubt that would take out Linux using the crtscts option!
The clock input and remote side ready just happen to occupy the same
pin. That would explain it flapping the ready so many times per second.

How do I turn on external clocking under linux?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
