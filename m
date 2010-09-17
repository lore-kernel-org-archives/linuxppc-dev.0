Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 777B11007DB
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 15:17:31 +1000 (EST)
Subject: Re: linux support for freescale e5500 core?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1284681832.30449.101.camel@pasglop>
Date: Fri, 17 Sep 2010 00:17:08 -0500
Message-Id: <7EDBB1DD-BB9D-417D-8F4E-B9D5D9E030EF@kernel.crashing.org>
References: <4C9278CD.10607@genband.com>
	<20100916163911.6255d359@schlenkerla.am.freescale.net>
	<4C928FC5.9050700@genband.com> <1284674628.30449.98.camel@pasglop>
	<4C92998C.7000903@nortel.com> <1284681832.30449.101.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Chris Friesen <chris.friesen@genband.com>,
	paulus@samba.org, Scott Wood <scottwood@freescale.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2010, at 7:03 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2010-09-16 at 16:26 -0600, Chris Friesen wrote:
>>> Sounds like a candidate for upstreaming the patch :-)
>>=20
>> As I recall we proposed upstreaming it a while back but there wasn't =
a
>> lot of interest since it's most useful in supporting poorly-written
>> legacy apps. :)=20
>=20
> Heh. Well as long as only 970 had that bit ... but with e5500 coming =
up
> with that too, I suppose it makes -some- sense. Let's at least look at
> the approach you took and we can decide based on how invasive/ugly it
> is :-)

Not sure how the 970 bit worked, but this seems a bit problematic for =
switching between kernel and application for how we do this on =
e500mc/e5500.  We'd have to touch the control bit on every exception =
path which seems ugly to me.

- k=
