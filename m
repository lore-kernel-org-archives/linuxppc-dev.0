Subject: RE: Lite5200 PCI not working
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 21 Jun 2004 13:12:49 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF5022754@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: "Gerhard Jaeger" <g.jaeger@sysgo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I don't understand, what do you mean "with both power LEDs off",
> the LEDs on the Lite5200? If yes, then I guess you have a problem!

Yes, I mean that. If the PCI card is plugged in the slot, when I connect the power, the LEDs in the Lite5200 board for 5V and 3.3V stay off. Without the PCI card, the Lite5200 works fine.

> And of course it should be inserted correctly - sorry if this is too obvious!

I think it is, but just to be sure: when I plug the card the RJ45 connector is in the side of the IDE connector of the Lite5200, in the opposite side of the "short part" of the PCI connector. Right?

> One card, that is known to work in this slot is the Intel eepro100 NIC.

I'll try to get ont of those, though I'm not sure if the timing problems in the PCI bus may cause the problem I'm seeing with this board. Thanks.

Ciao,
  Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
