Message-Id: <4.2.2.20010714123138.01d64dc0@mail.inkverse.com>
Date: Sat, 14 Jul 2001 13:02:17 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Jeremy Radlow <jtr@sourcerers.com>
Subject: Internal airport card not working? (2.4.6-benh)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Under 2.4.6 on an iBook, I'm apparently having ARP problems with Airport...

When I try to ping other machines on the network, I can see the activity
lights on my base station and the target machines' ethernet ports, and the
other machines on my LAN see the airport card in their ARP cache, but the
laptop with the airport card doesn't get anything in its ARP cache.

When I snoop the traffic using tcpdump, all I see is a bunch of spurious ARP
who-has messages originating from the laptop, and is-at messages originating
from the target machines.


My setup:
    transparent bridging on base station
    static IP's for all devices on the network (192.168.1.*)
    laptop is 5 feet away from base station

-Jeremy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
