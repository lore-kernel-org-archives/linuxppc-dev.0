From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	Derrik Pates <dpates@dsdk12.net>
Subject: Re: GMAC vs. SunGEM driver with 2.4.17?
Date: Wed, 2 Jan 2002 10:22:44 +0100
Message-Id: <20020102092244.23085@smtp.noos.fr>
In-Reply-To: <Pine.LNX.4.40.0201012147150.6346-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.40.0201012147150.6346-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ben? Anyone? I know the GMAC driver is supposed to eventually be phased
>out in favor of the SunGEM driver for iBooks and G4s with the GMAC
>ethernet controller, but for the time being, which is the better choice?
>For the system I'm using (a FireWire iBook), super-high performance isn't
>an issue really - since the PHY is only capable of 100Mbps anyway - but I
>figured I'd better find out.

You should be able to use sungem already. I've ported all the missing
bits (power management etc...) to it, and recently fixed the multicast
problem, so I see no reason to still use gmac.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
