Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 864D1DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 03:45:15 +1000 (EST)
Message-ID: <46DEEAC1.7020900@s5r6.in-berlin.de>
Date: Wed, 05 Sep 2007 19:43:29 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>	<20070827065246.GA21220@ime.usp.br>	<46D279E8.10001@edge.ping.de>	<46D72BC6.3020809@edge.ping.de>	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<20070905102824.a481060c.randy.dunlap@oracle.com>
In-Reply-To: <20070905102824.a481060c.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com,
	linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randy Dunlap wrote:
> On Wed, 5 Sep 2007 10:07:54 -0700 Andrew Morton wrote:
>>> So here is the output from dmesg that suggested to me that firewire 
>>> might be a problem:
>> Straightforward regression, two reporters, nothing happening.
> 
> (material for ksummit discussion, e.g.)

It's a simple thing in this incident:  I don't read all posts on LKML.
But I typically catch everything where I am in the CC list thanks to the
wonders of sieve.  Andrew, thanks for putting me in the CCs.
-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
