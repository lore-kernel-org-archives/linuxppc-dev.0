Date: Wed, 28 Mar 2001 16:04:26 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
	Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: Sound stoppage
In-Reply-To: <20010328142808.E1756DB9E8@atlas.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010328153139.32200E-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Mar 2001, Iain Sandoe wrote:

> - I've just looked at the "standard" 7200 tree (html-converted from the one
> at  suse) and there is a "compatible" entry.  "AAPL,7300 MacRISC"
>
> > I'd also like to know the bandit deviceID & revisionID in it's PCI config
> > space.
>
> there's a "model" property (AAPL,343S1126) in the Apple OF - perhaps this is
> different from the PowerComputing variant.

According to the oftree in /usr/lib/mol,

PowerBase 180 or 200:

compatible = "AAPL,e407", "MacRISC"
Bandit's model = "AAPL,343S1183"

StarMax 4160:

compatible = "AAPL,e826", "MacRISC"
Bandit's model = "AAPL,343S1183"

PowerMac 8500:

compatible = "AAPL,8500", "MacRISC"
Bandit's model = "AAPL,343S1126"

I wonder what PowerCenter or PowerTower reports..


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
