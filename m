Mime-Version: 1.0
Message-Id: <p05100301b7b43ee76981@[10.0.0.42]>
In-Reply-To: <15245.64975.629508.172270@titan.metzler>
References: <15244.11337.823289.698210@titan.metzler>
 <p05100304b7b1e866127d@[10.0.0.42]>
 <15244.47416.198967.661158@titan.metzler>
 <p05100300b7b28192a28d@[10.0.0.42]>
 <20010829041634.M28241@plato.local.lan>
 <p05100300b7b3044d8b12@[10.0.0.42]>	<p05100304b7b330c0fcdf@[10.0.0.42]>
 <15245.64975.629508.172270@titan.metzler>
Date: Thu, 30 Aug 2001 12:08:15 -0700
To: <mocm@convergence.de>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: firewire screwup (PB G4 reset procedure)
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:48 AM +0200 8/30/01, Marcus O.C. Metzler wrote:
>Timothy A. Seufert writes:
>  >
>  > My friend at Apple says to press and hold the reset button on the
>  > back of the powerbook (behind the I/O door) for at least 60 seconds.
>  >
>Nope, didn't work. Still SelfID Timeout in open firmware and no MacOs
>boot. Well at least linux still works.
>Is there a way to disable firewire, so that the MacOses won't probe
>for it and hang?

Possibly -- you could remove the firewire controller's node from the
OF device tree before booting MacOS, and then MacOS would be unlikely
to even know of its existence.  But I'm not nearly enough of an OF
hacker to know whether that's really possible, or how to do it.

I guess at this point damage must be considered likely.  Have you
tried using the Hardware Test CD that came with the computer?
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
