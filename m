Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id D2C2EDDD0D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 11:38:00 +1000 (EST)
Date: Thu, 12 Jul 2007 18:39:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Kconfig cleanup revisited
Message-ID: <20070713013953.GC29074@mag.az.mvista.com>
References: <20070712210156.973038514@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070712210156.973038514@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2007 at 11:01:56PM +0200, Arnd Bergmann wrote:
> Since this was brought up by Mark, here is a resend of the
> Kconfig cleanup patches that have not been merged so far,
> with updates for the comments I received.
> 
> I stumbled over another bug in the process, and fear I have
> found a can of worms there (not opened yet): There are
> still many files under arch/powerpc that include headers
> from include/asm-ppc/. Most of these includes can simply
> be removed, but some are real bugs, where generic code still
> relies on board-specific macro definitions.

Hi Arnd,

I really like what you've done here, thanks.

The patches don't apply straight up so what other patches do these go
on top of?

Mark
