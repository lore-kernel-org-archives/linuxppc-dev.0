Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AA45B6FF8
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2012 08:30:19 +1000 (EST)
Message-ID: <1338589800.16119.58.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 02 Jun 2012 08:30:00 +1000
In-Reply-To: <4FC8EDC4.2050704@freescale.com>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-01 at 11:28 -0500, Scott Wood wrote:
> 
> It's not really about CodeWarrior -- it's needed for any external
> debug
> on these chips.
> 
> Those chips are commercial products too, BTW. :-)

As long as it's not code to specifically interact with the CW software
it's ok.

I don't have a special axe to grind against CW (I use to love it under
ol' MacOS, though the new eclipse based one does seem to suck hard...
but then I never got a "licence" to use it past the demo anyway), it's
just that I don't want to start building SW interfaces to a foreign
tool.

BTW. My point of view is that this whole business about MSR:DE is a HW
design bug. There should be -no- (absolutely 0) interaction between the
SW state and the HW debugger for normal operations unless the user of
the debugger explicitly wants to change some state.

Cheers,
Ben.
