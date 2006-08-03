Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 50E02679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 23:54:42 +1000 (EST)
Date: Thu, 3 Aug 2006 06:54:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060803135440.GB3075@smtp.west.cox.net>
References: <3115459755319495cff4.1649760492.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3115459755319495cff4.1649760492.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 03, 2006 at 04:32:33AM -0500, Milton Miller wrote:

> I don't think we need to bump the dt version every time we make a tree
> content requirements change.  We need to bump when we add or
> change fields in the struct header, change internal layout, or change how
> we pass  information through the tree.  Certianly not because someone 
> left things out of their tree.

But "content requirements change" isn't the same as "left things out of
their tree".  It sounds, and I haven't seen the changes, so I'm not
certain that the meaning behind a field changed.  Something like that
should change the dt version.  New fields aren't a problem.  Changing
existing fields meaning in incompatible ways is a problem.

-- 
Tom Rini
