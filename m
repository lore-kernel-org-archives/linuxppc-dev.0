Date: Wed, 14 Nov 2001 08:15:59 -0500 (EST)
From: John & Trudy Phillips <johntrudy@adelphia.net>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Yenta IRQ's - none 
Message-ID: <Pine.LNX.4.33.0111140739260.2769-100000@johntrudy.phillips.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to get a Lucent/Orinoco wireless lan card working
on a new ( 550 MegaHz ) Titanium Powerbook.  I believe the
handling of IRQ's through the yenta_socket driver is broken.

Here is what I have observed/done to this point:

Kernel: linuxppc-2.4.14-benh

Yenta: clams irq 58

Cardmgr: version 3.1.22
	Starts with no errors

        If the card is present at the start of pcmcia, cardmgr
        identitifies the Lucent card as Lucent Tecnolodgies WaveLAN IEEE.

        Cardmgr does not recognize any pcmcia card if it is inserted
        after the pcmcia startup.

wvlan_cs: version 1.0.6
	Registers the card as netdevice eth1

iwconfig: reports the correct setup including the MAC address of the
	remote access point. So the receiver portion of the card
	appears to be correctly activated.

ifconfig: Complains that it can not set netmask 255.255.255.0 but
	does it anyway.

Once net work access is attempted, the wvlan_cs module reports
      eth1 Tx timed out Resetting card.

Through the entire process "cat /proc/interrupts" reports 0
interrupts on irq 58.  Has anyone seen interrupts handled on the
new Ti power book, or is this a known problem?

John M Phillips


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
