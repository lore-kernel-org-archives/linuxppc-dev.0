Date: Sat, 20 Dec 2003 19:45:01 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: weird pppoe/eth problem
Message-Id: <20031220194501.354e298a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Mac connected to internet via pppoe.
If the pppoe connection is up, and eth mtu is 1492 or 1490, it works for a
while. When it start receiving more data (eg. I load a webpage) the eth stops
receiving packets. A ping to any address, (even in the lan) fails and tcpdump
shows only the echo-req packet. The other machine on the lan does answer. To
make the eth work again I have to kill pppd and bring the eth down and up, or
detach and reattach the cable.
Ok, perhaps is not a good thing reducing the eth mtu, but the pppd should
complain or it should reduce its mtu accordigly if pppoe is supposed to respect
that limit. Anyway the ethernet shouldn't stop working.
Have you any idea where is the problem ?  I need some hint to figure out if
the bug is in the sungem driver, in the pppd (unlikely), or somewhere else.

I'll repeat the test on a PC (without the sunmgem driver) as soon as I can.

Linux Jay 2.4.23 #2 SMP sab dic 20 15:49:32 CET 2003 ppc unknown
pppd 2.4.2
PMac FW800, sungem eth0 driver

--
Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
