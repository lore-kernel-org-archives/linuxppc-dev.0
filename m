Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3214DDEF6
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 22:28:21 +1000 (EST)
In-Reply-To: <787b0d920705181845h355eed4fk2bf93323332a9d90@mail.gmail.com>
References: <787b0d920705172024g723412b4n8f82d3cd78e0f702@mail.gmail.com>
	<464DBDBA.3060801@ru.mvista.com>
	<787b0d920705181845h355eed4fk2bf93323332a9d90@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fa84736ae121902d4bee24eb23ca1d0b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Sat, 19 May 2007 14:28:14 +0200
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Unfortunately, FIT exists only on Book E CPUs and MPC74xx aren't Book 
>> E, IIUC.
>
> By the name "FIT" perhaps, but MPC74xx has essentially
> the same thing.

> Set MMCR0[TBEE], set MMCR0[PMXE], and choose a TBL bit via 
> MMCR0[TBSEL].

That's the performance monitor, which could very well be
in use already (for performance monitoring stuff, who
would have guessed).

> It's also possible to trigger on the CPU cycle counter, but this would
> cost one of the performance counters. MPC7400 has 4, later CPUs have 6
> or more, and I think xPC7x0 had only 2.

7xx has at least four as well.


Segher
