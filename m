Mime-Version: 1.0
Message-Id: <p05101000b836f0e87832@[10.0.0.42]>
In-Reply-To: <20011206180754.A23942@altus.drgw.net>
References: <20011206180754.A23942@altus.drgw.net>
Date: Fri, 7 Dec 2001 14:25:14 -0800
To: Troy Benjegerdes <hozer@drgw.net>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: HIGHMEM + serial console + SMP + 2GB freeze on pmac
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:07 PM -0600 12/6/01, Troy Benjegerdes wrote:

>This machine is an ealier Sawtooth G4 (7400) with 4 memory slots and 2GB
>of ram (I know, Macos does not support this).

[...]

>I'm going to try several other combinations of things, including taking
>one memory stick out since this could actually be that the hardware
>doesn't like that much memory.

MacOS X supports 2GB on Uni-N machines with four sockets, so the
hardware supports it.  I think the 1.5GB thing was just a consequence
of Classic MacOS having a fairly inflexible address space layout.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
