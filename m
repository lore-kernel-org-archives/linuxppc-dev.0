From: rshaw@graftononline.net
Message-ID: <002401c0296a$a321fe00$0100000a@nonewr2gx24hxi>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Using both (the 10Mbps and 100 Mbps) ports on CLLF 860T with Hard Hat Linux
Date: Thu, 28 Sep 2000 12:39:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using a CLLF 860T with Embedded PowerPC Cross Development Kit Rev. 1.2
Hard Hat Linux. I'm very new to Linux and developing for a board. Currently,
I'm booting manually (loading the kernel with tftp) using the 10 Mbps
ethernet port. I had to configure the kernel to use SCC1 so the 10 Mbps line
is used during the BOOTP requests.

>From the prompt in minicom I can make the cllf board ping my pc and from my
pc I can ping the cllf board, and this is using the 10 Mbps line. I will
also need to use the 100 Mbps line except I don't know if its possible to
use both ethernet ports and how to do it. Even if I could find a way to
switch between these ports, using only one port at a time, I would be happy.
Surely this is possible because the 10 Mbps port and 100 Mbps port have
different MAC addresses.

Thanks for any help!

Randy Shaw <rshaw@graftononline.net>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
