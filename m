Message-Id: <4.2.0.58.20001203235133.009a3620@engr.de.psu.edu>
Date: Sun, 03 Dec 2000 23:54:31 -0500
To: Jonathan Lane <jingai@shell.faradic.net>, debian-powerpc@lists.debian.org
From: Eric Reischer <reischer@psu.edu>
Subject: Re: 3COM 3c905c again
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200012040049.eB40ndh24760@shell.faradic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As for the PCI slots, I'm afraid I can't be much of any help.  The error
you are describing in your syslog, that basically means that your DHCP
server does not have any more IP addresses to give out to clients.  If you
administer this server, then you might want to consider adding more
addresses to the scope.  When the machine comes up, I'll bet if you do an
ifconfig, and take a look at your eth1 adapter settings (if it's there), it
won't have an IP address, which explains why packets aren't bouncing back
to your ping source.

Eric



At 07:49 PM 12/3/00 , Jonathan Lane wrote:
>Okay, I swapped cards around, and it turns out that *anything* in
>PCI slots 3-6 are not correctly configured (this is on a UMAX S900).
>I moved the USB card and NIC to slots 1 and 2, and my video card
>to slot 4, which appears to be working (although I've not tried
>using X yet, as XF86 4.0.1 is currently broken...).
>
>However, now I am having another problem:  When I ping the machine,
>I see the RX light on the NIC flash, but the source machine doesn't
>get any responses.
>
>A few things to note:  Every once in a while, I see the following
>message:
>
>         eth1: Setting promiscuous mode.
>
>Also, in my syslog, dhcpd complains with:
>
>Aug 27 16:42:20 colour dhcpd-2.2.x: DHCPDISCOVER from 08:00:46:05:9c:c8
>via eth1
>Aug 27 16:42:20 colour dhcpd-2.2.x: no free leases on subnet 192.168.1.0
>
>(Ignore the date, my clock had yet to be set).  But this indicates that
>packets *are* getting thru, as the MAC address shown above is correct.
>
>If anyone can shed some light on this matter, I'd greatly appreciate it.
>I'd also like to know why the last four PCI slots don't work properly,
>although it appears it's not incredibly important now, unless X doesn't
>work...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
