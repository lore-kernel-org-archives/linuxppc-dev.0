Date: Mon, 11 Feb 2002 16:49:06 -0800
From: andrew may <acmay@acmay.homeip.net>
To: =?iso-8859-1?Q?David_M=FCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Cc: andrew may <acmay@acmay.homeip.net>, Armin <akuster@pacbell.net>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC405gp enet Soft Reset
Message-ID: <20020211164906.A1822@ecam.san.rr.com>
References: <20020207191741.A26185@ecam.san.rr.com> <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com> <20020208103557.A27732@ecam.san.rr.com> <3C63AE1A.7000907@pacbell.net> <20020208120140.B27732@ecam.san.rr.com> <3C67B119.4080702@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3C67B119.4080702@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 11, 2002 at 12:55:05PM +0100, David Müller (ELSOFT AG) wrote:
> Hi
>
> andrew may wrote:
> > Here is a log from ppcboot since it is easy to test this there without doing
> > a kernel build. My phy is at address 0x1f.
> >
> > => mii read 0x1 2
> > 07FF
> > => mii read 0x1 3
> > read err 3
> > a2: read: EMAC_STACR=0xffffc023, i=2
> > Error reading from the PHY
> > 07FF
> >
>
> I'm seeing this error too on our boards. But i'm not certain, if it's a
> problem of the MII controller in the 405 or a problem of the LXT971.
> What revision of the 405 do you have? What clock frequency your 405 run at?

Well since I have no phy at address 1 I expect to get an error, but the problem
is that I am not getting an error when the register number is even.

The phy is at address 0x1f since it was easier for our hw guy to tie all the pins
to the same thing rather than put it at low address.

It is a RevE chip running at 266Mhz, the phy is an AMD Am79C874/ Altima AC101.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
