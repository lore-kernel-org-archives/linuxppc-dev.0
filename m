Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Trivial lexer cleanups 
In-Reply-To: Your message of "Wed, 05 Dec 2007 09:50:25 +1100."
	<20071204225025.GB9487@localhost.localdomain>
References: <20071204225025.GB9487@localhost.localdomain> 
Date: Wed, 05 Dec 2007 08:40:38 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvQU-0005aF-EF@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch applies a couple of tiny cleanups to the lexer.  The
> not-very-useful 'WS' named pattern is removed, and the debugging
> printf() for single character tokens is moved to the top of the
> action, which results in less confusing output when LEXDEBUG is
> switched on (because it goes before the printf()s for possible
> resulting lexer state changes).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
