Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: =?iso-8859-1?q?I=F1igo=20Lopez=20Barranco?= <ilopez@albatros-sl.es>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working
Date: Mon, 21 Jun 2004 13:48:35 +0200
References: <42A622EB18325843894BB8E1040E3DF5022754@sinaexchf>
In-Reply-To: <42A622EB18325843894BB8E1040E3DF5022754@sinaexchf>
MIME-Version: 1.0
Message-Id: <200406211348.35398.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Monday 21 June 2004 13:12, Iñigo Lopez Barranco wrote:
> >I don't understand, what do you mean "with both power LEDs off",
> > the LEDs on the Lite5200? If yes, then I guess you have a problem!
>
> Yes, I mean that. If the PCI card is plugged in the slot, when I connect
> the power, the LEDs in the Lite5200 board for 5V and 3.3V stay off.

--> short-circuit, I'm really surprised, that the board survived, sometimes,
ground connections from the PCI card tend to go up in smoke :-(

> Without the PCI card, the Lite5200 works fine.
>
> > And of course it should be inserted correctly - sorry if this is too
> > obvious!
>
> I think it is, but just to be sure: when I plug the card the RJ45 connector
> is in the side of the IDE connector of the Lite5200, in the opposite side
> of the "short part" of the PCI connector. Right?

NO NO!!! See Wolfgangs mail:
>>"You may have plugged it in incorrectly.  Make  sure  that  the  front
>>bezel  is on the side where the serial and USB connectors are - i. e.
>>NOT where the ATA connector is."

accoding to this, the part with the RJ45 connector should be on
the USB & serial connector side and NOT the way you did it now.
If in doubt, check the schematics and compare with the PCI specification...

>
> > One card, that is known to work in this slot is the Intel eepro100 NIC.
>
> I'll try to get ont of those, though I'm not sure if the timing problems in
> the PCI bus may cause the problem I'm seeing with this board. Thanks.

Probably not, but it is a hint, in case you encounter more PCI problems, when
the LEDs are on again ;-)

Ciao,
  Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
