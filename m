Mime-Version: 1.0
Message-Id: <p05100300b7b3044d8b12@[10.0.0.42]>
In-Reply-To: <20010829041634.M28241@plato.local.lan>
References: <15244.11337.823289.698210@titan.metzler>
 <p05100304b7b1e866127d@[10.0.0.42]>
 <15244.47416.198967.661158@titan.metzler>
 <p05100300b7b28192a28d@[10.0.0.42]>
 <20010829041634.M28241@plato.local.lan>
Date: Wed, 29 Aug 2001 13:48:51 -0700
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: firewire screwup
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:16 AM -0800 8/29/01, Ethan Benson wrote:
>On Wed, Aug 29, 2001 at 04:38:51AM -0700, Timothy A. Seufert wrote:
>>
>>  It isn't enough to remove the main battery of a PowerBook -- all Macs
>>  and PowerBooks have a tiny internal backup battery which keeps the
>>  real time clock and NVRAM contents alive when the normal power
>>  sources are not present.  You have to disconnect it if you want to
>>  reset anything.  You also need to allow time for all capacitors to
>>  fully discharge before the NVRAM is truly cleared (it's battery
>>  backed SRAM, and SRAM can keep its contents alive on microamps of
>>  current).  Overnight usually seems to be enough.
>
>that won't even work on a NewWorld, since on newworld nvram contents
>are stored in flash.

Did work on a New World for me (B&W).  Maybe only core99 & later use
flash for nvram?

I'll have to ask a guy I know at Apple about this.  He works with
prototype hardware&firmware that have lots of bugs, so the various
reset procedures are permanently burned into his brain.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
