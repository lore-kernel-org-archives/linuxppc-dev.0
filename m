Date: Wed, 29 Aug 2001 04:16:34 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: firewire screwup
Message-ID: <20010829041634.M28241@plato.local.lan>
References: <15244.11337.823289.698210@titan.metzler> <p05100304b7b1e866127d@[10.0.0.42]> <15244.47416.198967.661158@titan.metzler> <p05100300b7b28192a28d@[10.0.0.42]>
Mime-Version: 1.0
In-Reply-To: <p05100300b7b28192a28d@[10.0.0.42]>; from tas@mindspring.com on Wed, Aug 29, 2001 at 04:38:51AM -0700
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 29, 2001 at 04:38:51AM -0700, Timothy A. Seufert wrote:
>
> It isn't enough to remove the main battery of a PowerBook -- all Macs
> and PowerBooks have a tiny internal backup battery which keeps the
> real time clock and NVRAM contents alive when the normal power
> sources are not present.  You have to disconnect it if you want to
> reset anything.  You also need to allow time for all capacitors to
> fully discharge before the NVRAM is truly cleared (it's battery
> backed SRAM, and SRAM can keep its contents alive on microamps of
> current).  Overnight usually seems to be enough.

that won't even work on a NewWorld, since on newworld nvram contents
are stored in flash.

> It's probably worthwhile to try removing the backup battery -- I can
> tell you that I resurrected a Blue&White G3 that would not respond to
> anything else.   (I had put a value into an OF variable that caused
> the system to crash before OF could even respond to Cmd-Opt-P-R.)

i did something like that once as well, removing the battery did me no
good whatsoever.  only entering the backup OpenFirmware image worked
and allowed me to reset the nvram.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
