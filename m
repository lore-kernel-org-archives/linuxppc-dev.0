Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 9070D67A44
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 00:26:05 +1000 (EST)
Date: Mon, 22 May 2006 07:26:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Make early xmon logic immune to location of
	early parsing
Message-ID: <20060522142603.GC32112@smtp.west.cox.net>
References: <1147852841.148164.91320074069.qpush@concordia>
	<20060517212955.GA31362@smtp.west.cox.net>
	<1147910586.7360.8.camel@localhost.localdomain>
	<20060518010826.GO22868@smtp.west.cox.net>
	<1148281388.24345.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148281388.24345.40.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 22, 2006 at 05:03:08PM +1000, Michael Ellerman wrote:
[snip]
> But as far as xmon and kgdb is concerned it really shouldn't matter that
> the parsing is happening earlier. Instead of calling directly into
> xmon/kgdb from the parsing code you set a global which is tested later.

Yes, so instead of one method of telling the kernel we want to have kgdb
asap, and one method of implementing that on all architectures we have
the command line parsed sometimes (and we just drop right in), other
architectures we need to write something to set a flag we check later,
and someone else writes something different for this on yet another
platform and we're back to where we started from.  That's my fear :)

-- 
Tom Rini
