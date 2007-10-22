Return-Path: <dgibson@ozlabs.org>
Date: Mon, 22 Oct 2007 10:51:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071022005133.GG17164@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20d6133a9294d4f06a7e78ca627ec4f3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 21, 2007 at 07:30:45AM +0200, Segher Boessenkool wrote:
> > Property names have been limited to start with
> > characters from the set [a-zA-Z,._#?].  That is, the
> > digits and the expression symbols have been removed.
> 
> This cannot work; many property names start with a digit,
> for example.

Yes, crap.  Ok, I guess we just have to put the literal lexer rule
before the property name lexer rule, so literals will be recognized in
preference.  Disallowing just those property names which look like
literals is a little warty, but not likely to cause trouble in
practice, I think.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
