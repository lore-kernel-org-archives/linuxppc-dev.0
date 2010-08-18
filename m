Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDB0EB70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 15:03:39 +1000 (EST)
Subject: Re: 64-bit ppc rwsem (was: Re: [GIT] Sparc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <1282106338.22370.151.camel@pasglop>
References: <20100817.180325.104051399.davem@davemloft.net>
	<AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
	<AANLkTimZ3rhX2AzPExEGfRCXiFNN-BGOWRKqL241-qNa@mail.gmail.com>
	<20100817.191424.183031381.davem@davemloft.net>
	<1282106338.22370.151.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Aug 2010 15:03:23 +1000
Message-ID: <1282107803.22370.173.camel@pasglop>
Mime-Version: 1.0
Cc: torvalds@linux-foundation.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-08-18 at 14:38 +1000, Benjamin Herrenschmidt wrote:
> 
> Here's an untested patch for the folks on linuxppc-dev to look at,
> I'll
> review my own stuff & test tomorrow. 

Allright, gcc's being a pain, and atomics are a struct so we can't that
easily assign.

I tried various tricks but so far they didn't work. I'll have another
look tomorrow, but I may end up having to keep all the crap typecasts.

Cheers,
Ben.
