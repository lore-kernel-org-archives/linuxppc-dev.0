Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id C57C4679EF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 07:29:56 +1000 (EST)
Date: Wed, 17 May 2006 14:29:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Make early xmon logic immune to location of
	early parsing
Message-ID: <20060517212955.GA31362@smtp.west.cox.net>
References: <1147852841.148164.91320074069.qpush@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147852841.148164.91320074069.qpush@concordia>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 17, 2006 at 06:00:41PM +1000, Michael Ellerman wrote:

> Currently early_xmon() calls directly into debugger() if xmon=early is passed.
> This ties the invocation of early xmon to the location of parse_early_param(),
> which might change.
> 
> Tested on P5 LPAR and F50.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Please no, parse_early_param() is there so things like xmon or kgdb can
be dropped into as soon as we're able to parse any params that might be
usable early on.

-- 
Tom Rini
