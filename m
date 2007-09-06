Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52D73DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:23:46 +1000 (EST)
In-Reply-To: <20070904184810.GG18280@ld0162-tx32.am.freescale.net>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<20070904184810.GG18280@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1d766f8390851a75a6fe83800484ab7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Date: Thu, 6 Sep 2007 15:21:36 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That's wrong if lock is assigned to r0, you should use
>> a "b" constraint to avoid this. Same for atomic_dec below.
>
> GCC should really have removed r0 from the "r" class (it isn't truly a
> general-purpose register), and had a different class meaning 
> "r"-plus-r0.

Nah, GPR0 _is_ a general purpose register, you just cannot use all
general purpose registers as base registers ;-)

Either way, it's a bit late to change this, no?


Segher
