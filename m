From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "=?iso-8859-1?Q?David_M=FCller_=28ELSOFT_AG=29?=" <d.mueller@elsoft.ch>
Cc: "andrew may" <acmay@acmay.homeip.net>,
	"Armin" <akuster@pacbell.net>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405 MII-PHY communication problem (was: Re: PPC405gp enet Soft Reset)
Date: Tue, 19 Feb 2002 13:21:31 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJKECFDLAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3C723F98.7050402@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using a 4k7 pullup, and seem to have no problems.

> -----Ursprüngliche Nachricht-----
> Von: David Müller (ELSOFT AG) [mailto:d.mueller@elsoft.ch]
> Gesendet: Dienstag, 19. Februar 2002 13:06
> An: David Müller (ELSOFT AG)
> Cc: andrew may; Armin; Stefan Roese;
> linuxppc-embedded@lists.linuxppc.org
> Betreff: Re: 405 MII-PHY communication problem (was: Re: PPC405gp enet
> Soft Reset)
>
>
> Hi
>
> The problem with the even-numbered PHY register addresses seems to be
> caused by a too weak or totally missing pullup resistor on the MDIO line.
>
> David Müller (ELSOFT AG) wrote:
> >
> > Hi
> >
> > andrew may wrote:
> >
> >> On Mon, Feb 11, 2002 at 12:55:05PM +0100, David Müller (ELSOFT
> AG) wrote:
> >>
> >>> Hi
> >>>
> >>> andrew may wrote:
> >>>
> >>>> Here is a log from ppcboot since it is easy to test this there
> >>>> without doing
> >>>> a kernel build. My phy is at address 0x1f.
> >>>>
> >>>> => mii read 0x1 2
> >>>> 07FF
> >>>> => mii read 0x1 3
> >>>> read err 3
> >>>> a2: read: EMAC_STACR=0xffffc023, i=2
> >>>> Error reading from the PHY
> >>>> 07FF
> >>>>
> >>>>
> >>> I'm seeing this error too on our boards. But i'm not certain,
> if it's a
> >>> problem of the MII controller in the 405 or a problem of the LXT971.
> >>> What revision of the 405 do you have? What clock frequency your 405
> >>> run at?
> >>>
>
> [old stuff deleted]
>
>
>
> Dave
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
