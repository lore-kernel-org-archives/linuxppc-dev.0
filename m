Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 49D3AB6FEA
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2012 07:58:58 +1000 (EST)
Message-ID: <1335391128.21961.55.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Thu, 26 Apr 2012 07:58:48 +1000
In-Reply-To: <m2aa1zxyt7.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home> <1335388465.21961.35.camel@pasglop>
 <m2aa1zxyt7.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-25 at 23:54 +0200, Andreas Schwab wrote:
> 
> This fuzzing is what makes it much more annoying.
> 
Interesting, I didn't think that couple of percent of pwm would be
noticable (there's probably too much ambiant noise in the lab here for
me to notice).

What if you just comment out the tickle code ?

In theory it's only needed if we haven't changed any fan speed for a
long time (the FCU can then timeout and assume we aren't driving it,
ramping up all fans to full speed). I could implement that a bit more
intelligently.

Cheers,
Ben.
