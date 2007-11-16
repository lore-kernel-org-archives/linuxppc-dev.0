Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80EF0DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 18:48:42 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071116074025.GA4741@lixom.net>
References: <20071116072149.350ADDDDF4@ozlabs.org>
	<20071116074025.GA4741@lixom.net>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 18:41:08 +1100
Message-Id: <1195198868.28865.142.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-16 at 01:40 -0600, Olof Johansson wrote:
> I'm not sure I like this. It introduces another cpu feature flag,
> that we'll soon run out of if it's used to signify version info per
> implementation like this.
> 
> 1) The SET_IVOR could be done from the cpu_setups for 440A instead
> (i.e. introduce one).
> 
> 2) Please just move the machine check handlers out to individual ones
> instead of using the generic one. That way you don't need runtime checks
> between the two (they don't seem to share much of it as-is anyway).
> 
> With the above two changes, you shouldn't need the feature bit any more.

We can easily make the cpu features bigger ... But ok, I'll have a look
at doing it the way you suggest.

Cheers,
Ben.
