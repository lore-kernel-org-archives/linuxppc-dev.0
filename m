Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 263ACB6EEC
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2012 17:59:11 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home> <1335388465.21961.35.camel@pasglop>
 <m2aa1zxyt7.fsf@igel.home> <1335391128.21961.55.camel@pasglop>
 <m2liliam9w.fsf@igel.home> <1335431975.21961.75.camel@pasglop>
 <m2ehra67p5.fsf@igel.home> <1335477999.21961.85.camel@pasglop>
Date: Fri, 27 Apr 2012 09:59:04 +0200
In-Reply-To: <1335477999.21961.85.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Fri, 27 Apr 2012 08:06:39 +1000")
Message-ID: <m2ty054ncn.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Ok, I'll switch that back then. It seemed more sensible to read the
> actual fan values rather than the programmed ones (in fact I wonder if I
> can just skip the read alltogether then and use a cached value but that
> means I won't be able to detect failed fans...), but if you say it
> behaves better, let's keep it the way it was.

I don't actually care too much about this, since the most annoyance came
from the slots fan.

> As for the tickle, I'm not sure yet how to proceed. I'll look into it,
> try various things. We can maybe just remove the tickle but that means
> that a completely idle machine might start ramping up as the FCU times
> out.

The old driver gets away with it probably because it always writes to
the fcu even if the speed didn't change.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
