Mime-Version: 1.0
Message-Id: <p04330101b81f8b04f001@[24.25.19.40]>
Date: Mon, 19 Nov 2001 23:58:35 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: tulip debugging
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm on a 6500 running 2.4.14 rsynced from the bk tree, with a
Farallon 10/100 NIC (dmesg reports eth0: Digital DS21143 Tulip rev 65
at 0xc81fa000). This has long been a thorn in my side, with no
ethernet card ever working for long in the 6500 before the network
just "freezes," but with a new install of YDL 2.1, I'm game for
troubleshooting it again. Maybe someone here is interested in the
tulip driver?

So I've got the tulip driver compiled as a module, and I'm just going
to start with some simple questions that I don't understand. BTW, I'm
not using modprobe and I have no tulip references in modules.conf
because there are no other module dependencies, and I'm not sure what
modprobe might do that I can't see.

First, I'm not sure the interface is "starting up" correctly. I'm
using a NetGear 10/100 switch to monitor the interface speed and
duplex setting. In my usual experience, when the network is stopped,
the lights go off. But with this tulip driver, that's not the case.
First, network stop shuts the interface down but not "the lights."
rmmod tulip doesn't either. Finally, insmod tulip does shut the
lights off, and network start brings them back on again. Is this
correct behavior?

Second, I am trying to control the duplex setting but without
success. Tulip options are full_duplex=1-8. Not a single one of those
causes the interface to be half-duplex. Is it even possible to
control the duplex setting in this way?

Ultimately, I'm trying to control both the speed and the duplex to
see if I can make the card work. No matter what I do so far, the card
only comes up as full duplex and speed 100.


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
