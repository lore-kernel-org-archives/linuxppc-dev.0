Date: Wed, 26 Sep 2001 23:27:42 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109270627.XAA14161@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC824x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We are looking at doing 8245 with 100Mhz
memory bus and a separate MPC107 bus for
66Mhz operation. We like the 8245 since it
supports 133Mhz memory bus which would
prevent the bus loading problems inherent
in previos 8240 designs which had
several ROM (PortX) devices.

Does anyone have a working port of ppclinux
(preferably HHL 2.0) ? The serial port seems
trivial since it is a memmapped NS16552.

Other than the memory initialization code,
has the port from 8240 to 8245 been relatively
easy? It seems like the right place to start
would be SandPoint X3 with an 8245PMC module.

Many thanks in advance.

				-James

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
