Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02FCBB70A3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 10:04:06 +1000 (EST)
Subject: Re: linux support for freescale e5500 core?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4C92998C.7000903@nortel.com>
References: <4C9278CD.10607@genband.com>
	<20100916163911.6255d359@schlenkerla.am.freescale.net>
	<4C928FC5.9050700@genband.com> <1284674628.30449.98.camel@pasglop>
	<4C92998C.7000903@nortel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 10:03:52 +1000
Message-ID: <1284681832.30449.101.camel@pasglop>
Mime-Version: 1.0
Cc: Chris Friesen <chris.friesen@genband.com>,
	Scott Wood <scottwood@freescale.com>, paulus@samba.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-16 at 16:26 -0600, Chris Friesen wrote:
> > Sounds like a candidate for upstreaming the patch :-)
> 
> As I recall we proposed upstreaming it a while back but there wasn't a
> lot of interest since it's most useful in supporting poorly-written
> legacy apps. :) 

Heh. Well as long as only 970 had that bit ... but with e5500 coming up
with that too, I suppose it makes -some- sense. Let's at least look at
the approach you took and we can decide based on how invasive/ugly it
is :-)

Cheers,
Ben.
