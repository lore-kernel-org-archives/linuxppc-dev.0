MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 826x FCC ethernet in promiscuous mode
Date: Tue, 27 Apr 2004 13:39:12 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAC5@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I cannot seem to get  the FCC ethernet controller on a 8266 to do
promiscous mode correctly.
I am trying to use tcpdump to show some traffic on a hub it is
conneccted to (and yes it is a hub, not a switch). Tcpdump does not show
anything but what it would show normally (ie broadcast and packets
addressed to the interface)

I have tested the hub using another computer running ethereal and it can
se everything it is supposed to.

Any ideas?
(I had a quick look in the sources, and it seems that the promiscous bit
gets set)

This is running on 2.6.5



On a related note... Anybodyu know how to get linux to see RFC-1042
formated ARP packets?

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
