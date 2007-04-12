Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7D50DDF65
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:19:28 +1000 (EST)
In-Reply-To: <3F3BE390-906F-4B14-92DB-BA6BB191D022@kernel.crashing.org>
References: <20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070411.212548.95037188.davem@davemloft.net>
	<3F3BE390-906F-4B14-92DB-BA6BB191D022@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <988b41318b455a295da4284d24680377@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH,RFC] Split out common parts of prom.h
Date: Thu, 12 Apr 2007 21:19:13 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Should we drop prom.h all together.

That presumably is the final goal.  It'll take a
while to get there, though, and in the meantime
prom.h is there for backward compatibility.

> I haven't looked but I would
> think OLPC would need (or use) some of this as well since its using OF.

The OLPC kernel currently doesn't use OF; it guesses
a lot instead, just like on any other x86 machine.
This can change though, but it's not a priority for
the OLPC project right now (since things "work" anyway).


Segher
