From: desrice@comcast.net
To: mporter@kernel.crashing.org, linuxppc-embedded@lists.linuxppc.org
Subject: Ethernet Driver
Date: Mon, 17 May 2004 17:40:51 +0000
Message-Id: <051720041740.24419.40A8F923000C6ADF00005F6322007511500A0C079D9C0A0B@comcast.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI Guys

I'm wonder if anyone has seen this problem and can maybe help. I'm
working with the IBM 405H ( on our custom board ) processor and Monta
Vista Linux Kernel of linux-2.4.17_mvl21. I have updated the Ethernet
driver to support two Ethernet Interfaces, which use EMAC 0 and EMAC 2
(This is where our two Phys are physically connected to.). The problem
I'm seeing is that on interface 2 ( EMAC 2 ) when a line rate of 3% ,
with 64 byte packet size , is exceeded, MAL0 RX descriptor errors are
continuously generated. This failure has two types of symptoms when the
traffic to the port is removed :

1. The MAL0 descriptor errors cease soon after the traffic is removed,
and the system recovers
2. The MAL0 descriptor errors never cease and the system is continuously
handling the error.

Thanks in Advance
Des

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
