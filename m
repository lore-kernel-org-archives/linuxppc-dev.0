Mime-Version: 1.0
Message-Id: <p05100300b7b28192a28d@[10.0.0.42]>
In-Reply-To: <15244.47416.198967.661158@titan.metzler>
References: <15244.11337.823289.698210@titan.metzler>
 <p05100304b7b1e866127d@[10.0.0.42]>
 <15244.47416.198967.661158@titan.metzler>
Date: Wed, 29 Aug 2001 04:38:51 -0700
To: <mocm@convergence.de>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: firewire screwup
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:43 AM +0200 8/29/01, Marcus O.C. Metzler wrote:
>Timothy A. Seufert writes:
>  >
>  > I think you may have corrupted nonvolatile memory.  Try doing a
>  > complete PRAM wipe: turn the computer on while holding Cmd+Opt+P+R
>  > and let it do several reboot / PRAM wipe cycles in a row.  Five or
>  > six is probably enough.  (The first PRAM wipe doesn't clear
>  > everything.  The firmware watches to see if you do several in a row
>  > and will do successively more thorough resets on each iteration.)
>  > --
>  > Tim Seufert
>  >
>
>I tried 6 cycles of the PRAM wipe, but still get the SELFID Timeout in
>open firmware and no boot of any MacOs. I also tried disconnecting the
>power and taking out the battery, still the same problem.

It isn't enough to remove the main battery of a PowerBook -- all Macs
and PowerBooks have a tiny internal backup battery which keeps the
real time clock and NVRAM contents alive when the normal power
sources are not present.  You have to disconnect it if you want to
reset anything.  You also need to allow time for all capacitors to
fully discharge before the NVRAM is truly cleared (it's battery
backed SRAM, and SRAM can keep its contents alive on microamps of
current).  Overnight usually seems to be enough.

I don't know where the backup battery is located in the PB G4.  It
may not be very easy to get to.

It's probably worthwhile to try removing the backup battery -- I can
tell you that I resurrected a Blue&White G3 that would not respond to
anything else.   (I had put a value into an OF variable that caused
the system to crash before OF could even respond to Cmd-Opt-P-R.)

P.S.  I don't think your hardware is damaged -- what you did should
not have any potential to do that.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
