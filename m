From: Benjamin Herrenschmidt <bh40@calva.net>
To: Stefan Jeglinski <jeglin@4pi.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: whacked out 2.2.18pre17?
Date: Sat, 4 Nov 2000 13:47:40 +0100
Message-Id: <19340929061924.29978@192.168.1.10>
In-Reply-To: <p04330100b629527c3036@[192.168.0.1]>
References: <p04330100b629527c3036@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The two things that are constant on my hardware (PowerTowerPro +
>PowerLogix G3, 6 PCI cards, most of which are not seen anyway,
>2940UW):
>
>1. Full boot is impossible, always with one of the following circumstances:
>	a) freeze at "booting..."
>	b) can't find MAC address for MACE device -> kernel panic
>	c) "machine check in kernel mode" -> "unknown values in srr1" ->
>		kernel panic

That's weird. The symptoms you describe are typicall of a kernel beeing
damaged by bus-mastering devices (your 6 PCI cards frighten me ...).

But in this case, 2.2.17 should have the same problems.

No explanation come to my mind. Did you try removing some PCI cards to
see if one could be the cause of the problem ? I don't see any of the
2.2.18 change that could explain your problem.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
