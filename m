Message-Id: <v04003a07b650c6f2cb3c@[24.70.162.12]>
In-Reply-To: <200012040049.eB40ndh24760@shell.faradic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 3 Dec 2000 22:11:46 -0600
To: Jonathan Lane <jingai@shell.faradic.net>, debian-powerpc@lists.debian.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: 3COM 3c905c again
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:49 PM -0600 12/3/2000, Jonathan Lane wrote:
>(although I've not tried
>using X yet, as XF86 4.0.1 is currently broken...).

X4 works for me[tm] on my 9600 with debian. Of course, I seem to be the
only person on the planet who's got X working in a 9600, with an imstt, in
the bottom slots, without offb, etc etc etc, so ymmv.


>However, now I am having another problem:  When I ping the machine,
>I see the RX light on the NIC flash, but the source machine doesn't
>get any responses.
>
>A few things to note:  Every once in a while, I see the following
>message:
>
>	eth1: Setting promiscuous mode.

Probably from dhcpcd sending out a broadcast to find a DHCP server.


>Also, in my syslog, dhcpd complains with:
>
>Aug 27 16:42:20 colour dhcpd-2.2.x: DHCPDISCOVER from 08:00:46:05:9c:c8
>via eth1
>Aug 27 16:42:20 colour dhcpd-2.2.x: no free leases on subnet 192.168.1.0
>
>(Ignore the date, my clock had yet to be set).  But this indicates that
>packets *are* getting thru, as the MAC address shown above is correct.

Check your DHCP server configuration and logfiles. It would appear your
server doesn't want to give your client an IP address.

Note that when dhcpcd doesn't get an IP address, it will deconfigure the
interface it's on, thus not allowing any traffic through.


>If anyone can shed some light on this matter, I'd greatly appreciate it.
>I'd also like to know why the last four PCI slots don't work properly,
>although it appears it's not incredibly important now, unless X doesn't
>work...

I think there's some PCI bogosity in the standard 2.2 kernels when it comes
to PCI-PCI bridges. I've had fairly good luck with 2.2 with a PCI patchset
that I don't recall the URL of, and more recently, with 2.4 rsynced from
penguinppc.

Someone else can answer with more authority on the subject.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
