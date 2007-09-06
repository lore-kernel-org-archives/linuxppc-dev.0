Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A632DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:11:56 +1000 (EST)
In-Reply-To: <20070906134354.GA16153@ld0162-tx32.am.freescale.net>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<20070904184810.GG18280@ld0162-tx32.am.freescale.net>
	<e1d766f8390851a75a6fe83800484ab7@kernel.crashing.org>
	<20070906134354.GA16153@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b976a70bd1942da7e31b9a409b2de569@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Date: Thu, 6 Sep 2007 16:09:53 +0200
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

>> Either way, it's a bit late to change this, no?
>
> Sure, I was just whining due to having been bitten by this sort of bug 
> in
> the past. :-)

Write a song about it, it's therapeutical it seems!


Segher
