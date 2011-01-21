Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAF2AB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 08:16:11 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix some 6xx/7xxx CPU setup functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTikd14Kw02nzde19FsR9JUGA=c-xzVVXpkGLoUjf@mail.gmail.com>
References: <1295591723.2148.281.camel@pasglop>
	<AANLkTikd14Kw02nzde19FsR9JUGA=c-xzVVXpkGLoUjf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 22 Jan 2011 08:16:03 +1100
Message-ID: <1295644563.2148.306.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-01-21 at 12:15 -0600, kevin diggs wrote:

> I have a GigE (PowerMac 3,4?) with an upgrade card that has a pair of
> 7455s on it and an 8600 with a 750GX cpu card. I can probably test
> this on the GigE. It is running 2.6.36. Is that recent enough? The
> 8600 is not cooperating.
> 
> The GigE is running 2.6.36 compiled with 4.3.5 built from sources. It
> seems to run fine. 

The bug would have caused the kernel to allow enabling of "nap" mode
when idle on machines where this is buggy and can cause loss of cache
coherency among others. I really don't remember off hand which specific
machines may or may not have been affected. But I'd like at least people
to verify that my patches to "fix" that aren't causing a regression for
people like you who don't seem to have problems :-)

The bug was introduced a while back in 2005.

Cheers,
Ben.
