From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "=?iso-8859-1?Q?David_M=FCller_=28ELSOFT_AG=29?=" <d.mueller@elsoft.ch>,
	"andrew may" <acmay@acmay.homeip.net>
Cc: "Armin" <akuster@pacbell.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405 MII-PHY communication problem (was: Re: PPC405gp enet Soft Reset)
Date: Wed, 13 Feb 2002 16:15:50 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJOENHDKAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3C6A25BC.7010704@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

just to let you know:

We have PPC405GP Rev D & Rev E running @ 198 MHz with Intel LXT971LE @
address 0, and seem to have none of your described problem:

=> mii info
PHY 0x00: OUI = 0x04DE, Model = 0x0E, Rev = 0x01, 100baseT, FDX
read err 3
a2: read: EMAC_STACR=0xffffc023, i=3
read err 3
a2: read: EMAC_STACR=0xffffc043, i=3
read err 3

etc...

Stefan Roese


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
