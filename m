From: August Hoerandl <ahoerandl@gmx.at>
Reply-To: ahoerandl@gmx.at
To: Brad Bonkoski <bradb59@home.com>,
	ppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ethernet on 8260
Date: Tue, 17 Jul 2001 10:28:42 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
References: <20010717002518.YUJE5550.femail18.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
In-Reply-To: <20010717002518.YUJE5550.femail18.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
MIME-Version: 1.0
Message-Id: <01071710284300.00821@linuxhoe>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 17 July 2001 02:19 am, Brad Bonkoski wrote:
> Hello,
>
> I am working with a custom 8260 board which has 3 Ethernet devices that
> are on using FCC to communicate.  When I try to activate all three I get
> some funny routing.  Essentailly, I have them all set up on the same
> network: 192.168.0.X.  When I try to ping one Ethernet device, the
> system tries to respond on another.  What could lead to this problem?

you should not put more then one "real" device into one subnet - the
kernel will always check with the netmask and use the first one that
matches, there is no idea of "the request was on eth2, the answer has
to go out on eth2"

hth
Gustl

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
