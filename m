Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA2762BDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 12:59:58 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20040924164146.GG2107@smtp.west.cox.net>
References: <20040923164655.0472a8b9.sfr@ozlabs.org>
	<20040923233035.GH27238@smtp.west.cox.net>
	<36b714c80409231731257ca5d0@mail.gmail.com>
	<29D00F8B-0DC8-11D9-A0FB-000A95A0560C@penguinppc.org>
	<DA7E9084-0DED-11D9-A74B-003065F9B7DC@embeddededge.com>
	<20040924164146.GG2107@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1096081145.475.12.camel@gaston>
Mime-Version: 1.0
Date: Sat, 25 Sep 2004 12:59:06 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: New mailing list specifically for embedded PowerPC development
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I specifically asked for the split.

The reason is that my bandwidth with mailing lists is small enough that
I need a way to quickly spot a patch that will be of interest to the
core kernel (like the recent Machine Check changes, for example) from
the 128654th guy asking why his FCP/OCP/Whatever embedded ethernet doesn't
get a proper MAC address with zeeBoot rev 187.387b4...

There is simply too much noise on the embedded lists, if the lists are
merged, I'll simply not be able to follow the new list and will probably
miss important/interesting stuffs.

To reply to Matt, "then where do pmac-specific discussions belong?", well,
how much pmac specific messages have you seen on linuxppc-dev in the past
few (monthes/years) ?

It's really a matter of signal/noise ratio.

Ben.
