Date: Mon, 6 Mar 2000 15:32:17 -0500
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Intermittant ethernet...
Message-ID: <20000306153216.A278@wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey, just thought I'd email the list with a fix for the variant of
intermittent Ethernet I was experiencing.

It would manifest itself by making Ethernet drop every couple of minutes or
so, for about 10-20 seconds.

This drove me nuts, obviously, and I eventually traced it to my dhcpcd
server, doing funny things with trying to renew my ip, and turning it off
temporarily, also messing with the routing table.

The fix for me was to not use dhcpcd, and use dhclient instead.

I don't know if this is related to what people are seeing with ftp/ssh, but
it fixed my problem.

FYI, I've got a PowerBook WS/233 Mhz

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
