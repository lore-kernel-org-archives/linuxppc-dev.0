Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03BB22BDF2
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Dec 2004 22:09:24 +1100 (EST)
Date: Thu, 2 Dec 2004 12:08:27 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041202120827.24635143@pirandello>
In-Reply-To: <1101877409.5672.2.camel@gaston>
References: <1101877409.5672.2.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01 Dec 2004 at 16h12, Benjamin Herrenschmidt wrote:

Hi, 
 
> This one fixes finally the cache flush problem that made cpufreq (on machines
> using the PMU for the switch) and sleep/wake unreliable occasionally (memory
> corruption would occur on some CPUs at least). It improves bits here or there
> too, and adds the sungem wake-on-lan feature. 

By the way, I noticed a problem when the laptop is put to sleep by closing lid:
wake-on-lan still works, but as soon as the laptop's awake, pbbuttonsd sleeps 
it again. Combined with the fact that a closed iBook G4 not sleeping shutdowns 
by itself, it would be nice if sungem could disable wol when suspending and the 
lid is closed - if such info is available.

Or maybe such a thing should be done in the pbbuttonsd scripts by calling 
ethtool?
-- 
Colin
