In-Reply-To: <v04220801b4d927f346db@[10.0.0.42]>
Date: Wed, 23 Feb 2000 10:38:33 +0100
To: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: PowerMac G4 and pcmcia flash cards
Message-Id: <20000223103833.001863@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 22, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:

>Well, you're going to face a pretty fundamental barrier in that the
>G4 does not have any PCMCIA sockets.  Despite appareances, the
>internal AirPort socket on the AGP models is not PCMCIA.  It will not
>work at all with anything other than an AirPort card.

Actually, it smells a lot like a PCMCIA (not CardBus). It looks like a
kind of bastard of a PCMCIA and an IDE bus, and it's possible that some
PCMCIA card be made to work on it. I don't have enough infos for this yet
however.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
