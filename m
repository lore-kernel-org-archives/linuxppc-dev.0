Date: Sun, 3 Dec 2000 19:49:39 -0500
From: Jonathan Lane <jingai@shell.faradic.net>
Message-Id: <200012040049.eB40ndh24760@shell.faradic.net>
To: debian-powerpc@lists.debian.org
Subject: 3COM 3c905c again
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, I swapped cards around, and it turns out that *anything* in
PCI slots 3-6 are not correctly configured (this is on a UMAX S900).
I moved the USB card and NIC to slots 1 and 2, and my video card
to slot 4, which appears to be working (although I've not tried
using X yet, as XF86 4.0.1 is currently broken...).

However, now I am having another problem:  When I ping the machine,
I see the RX light on the NIC flash, but the source machine doesn't
get any responses.

A few things to note:  Every once in a while, I see the following
message:

	eth1: Setting promiscuous mode.

Also, in my syslog, dhcpd complains with:

Aug 27 16:42:20 colour dhcpd-2.2.x: DHCPDISCOVER from 08:00:46:05:9c:c8 via eth1
Aug 27 16:42:20 colour dhcpd-2.2.x: no free leases on subnet 192.168.1.0

(Ignore the date, my clock had yet to be set).  But this indicates that
packets *are* getting thru, as the MAC address shown above is correct.

If anyone can shed some light on this matter, I'd greatly appreciate it.
I'd also like to know why the last four PCI slots don't work properly,
although it appears it's not incredibly important now, unless X doesn't
work...

TIA,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
