Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6AB3867A7F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 08:05:38 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Graham Wilson <graham@mknod.org>
In-Reply-To: <20050329190703.GA15755@mknod.org>
References: <1111964111.6099.19.camel@gaston>
	<20050329190703.GA15755@mknod.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 08:04:37 +1000
Message-Id: <1112133877.6577.35.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix sleep/wakeup problems on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I've been having various trouble with my iBook lately, including random
> freezes, not waking up after going to sleep sometimes, and sometimes not
> going to sleep. Since applying the patch you posted, everything seems
> fine, though I may be speaking too soon.
> 
> My /proc/cpuinfo for reference:
>  processor	: 0
>  cpu		: 750FX
>  temperature 	: 0-3 C (uncalibrated)
>  clock		: 400MHz
>  revision	: 2.3 (pvr 7000 0203)
>  bogomips	: 793.71
>  machine		: PowerBook4,3
>  motherboard	: PowerBook4,3 MacRISC2 MacRISC Power Macintosh
>  detected as	: 257 (iBook 2 rev. 2)
>  pmac flags	: 0000001b
>  L2 cache	: 512K unified
>  memory		: 256MB
>  pmac-generation	: NewWorld
> 
> Note that the maximum CPU speed is 900 MHz.

Can you also check my other patch which fixes cpufreq as well ? And test
if it's reliable wether you sleep at low or high speed ?

Thanks,
Ben.
