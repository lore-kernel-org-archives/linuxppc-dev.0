Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 640FA2BDB5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2004 22:24:46 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041202120827.24635143@pirandello>
References: <1101877409.5672.2.camel@gaston>
	<20041202120827.24635143@pirandello>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 22:24:04 +1100
Message-Id: <1101986644.5592.82.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-12-02 at 12:08 +0100, Colin Leroy wrote:
> On 01 Dec 2004 at 16h12, Benjamin Herrenschmidt wrote:
> 
> Hi, 
>  
> > This one fixes finally the cache flush problem that made cpufreq (on machines
> > using the PMU for the switch) and sleep/wake unreliable occasionally (memory
> > corruption would occur on some CPUs at least). It improves bits here or there
> > too, and adds the sungem wake-on-lan feature. 
> 
> By the way, I noticed a problem when the laptop is put to sleep by closing lid:
> wake-on-lan still works, but as soon as the laptop's awake, pbbuttonsd sleeps 
> it again. 

Useland shit :)

> Combined with the fact that a closed iBook G4 not sleeping shutdowns 
> by itself, it would be nice if sungem could disable wol when suspending and the 
> lid is closed - if such info is available.

Userland shit (bis) :)

> Or maybe such a thing should be done in the pbbuttonsd scripts by calling 
> ethtool?
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
