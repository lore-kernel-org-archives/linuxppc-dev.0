Date: Thu, 21 Feb 2002 16:56:21 -0800
From: andrew may <acmay@acmay.homeip.net>
To: =?iso-8859-1?Q?David_M=FCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Cc: andrew may <acmay@acmay.homeip.net>, Armin <akuster@pacbell.net>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 MII-PHY communication problem (was: Re: PPC405gp enet Soft Reset)
Message-ID: <20020221165621.A21452@ecam.san.rr.com>
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com> <3C63AE1A.7000907@pacbell.net> <20020208120140.B27732@ecam.san.rr.com> <3C67B119.4080702@elsoft.ch> <20020211164906.A1822@ecam.san.rr.com> <3C6A25BC.7010704@elsoft.ch> <3C723F98.7050402@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3C723F98.7050402@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 19, 2002 at 01:05:44PM +0100, David Müller (ELSOFT AG) wrote:
> Hi
>
> The problem with the even-numbered PHY register addresses seems to be
> caused by a too weak or totally missing pullup resistor on the MDIO line.

Yep, that seems to solve it here as, well. The phy wants a 1.5k pull up.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
