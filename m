From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <anton@samba.org>, <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Date: Wed, 21 Nov 2001 02:25:57 +0100
Message-Id: <20011121012557.25248@smtp.adsl.oleane.com>
In-Reply-To: <20011120.161937.118616800.davem@redhat.com>
References: <20011120.161937.118616800.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>As a result GEM sends pause frames when there is even the slightest
>amount of DMA traffic is has to compete with.  On a 33Mhz/32-bit PCI
>bus, it is sending pause frames all the time even if it is the only
>agent making use of the bus.

Ok. At least, the UniNorth version runs on a 66Mhz bus directly
hooked to the CPU bus within the north bridge. The only other device
sharing that PCI segment is FireWire (well, it's a bandwidth hog
too be more rarely used so far).

Thanks for the clarification.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
