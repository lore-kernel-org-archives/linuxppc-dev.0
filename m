Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1478F2BDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 20:06:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041201083617.5b72a115@pirandello>
References: <1101877409.5672.2.camel@gaston>
	<20041201083617.5b72a115@pirandello>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 20:05:33 +1100
Message-Id: <1101891934.5592.0.camel@gaston>
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

On Wed, 2004-12-01 at 08:36 +0100, Colin Leroy wrote:
> On 01 Dec 2004 at 16h12, Benjamin Herrenschmidt wrote:
> 
> Hi Ben, 
> 
> > This one fixes finally the cache flush problem that made cpufreq (on machines
> > using the PMU for the switch) and sleep/wake unreliable occasionally (memory
> > corruption would occur on some CPUs at least). It improves bits here or there
> > too, and adds the sungem wake-on-lan feature. 
> 
> Compiling that. btw, you didn't add the "&& !wol" before sungem's suspend call...


What do you mean ? the whole code block is now in !wol...

Note that I'm still having problems with the cache ... I'm asking
Moto/Freescale...

Ben.
