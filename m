Mime-Version: 1.0
Message-Id: <v04220801b4d96f71804f@[10.0.0.42]>
In-Reply-To: <20000223103833.001863@mailhost.mipsys.com>
References: <20000223103833.001863@mailhost.mipsys.com>
Date: Wed, 23 Feb 2000 03:15:06 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PowerMac G4 and pcmcia flash cards
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:38 AM +0100 2/23/00, Benjamin Herrenschmidt wrote:
>On Tue, Feb 22, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:
>
>>Well, you're going to face a pretty fundamental barrier in that the
>>G4 does not have any PCMCIA sockets.  Despite appareances, the
>>internal AirPort socket on the AGP models is not PCMCIA.  It will not
>>work at all with anything other than an AirPort card.
>
>Actually, it smells a lot like a PCMCIA (not CardBus). It looks like a
>kind of bastard of a PCMCIA and an IDE bus, and it's possible that some
>PCMCIA card be made to work on it. I don't have enough infos for this yet
>however.

It smells tantalizingly like PCMCIA because it's very close, but it
is deliberately broken so that it's not compatible with the regular
PCMCIA pinout.  This allows Apple to sell AirPort cards for $100 USD
without creating a gray market supply of cheap IEEE 802.11 cards,
which would undercut everyone else in the world who is selling the
same thing for $150-200.  When big companies cut special high volume
deals, ugly things happen.  :)

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
