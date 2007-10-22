Return-Path: <dgibson@ozlabs.org>
Date: Mon, 22 Oct 2007 10:37:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] DTC: Begin the path to sane literals and expressions.
Message-ID: <20071022003703.GD17164@localhost.localdomain>
References: <E1Iivsg-00078a-Vp@jdl.com>
	<20071020084737.GG26642@localhost.localdomain>
	<6a6fcd2bc9b0121cb5e9cfc675d88f57@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a6fcd2bc9b0121cb5e9cfc675d88f57@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 21, 2007 at 07:32:33AM +0200, Segher Boessenkool wrote:
> >> Use of "d#', "o#", "h#" and "b#" are gone in version 1.
> >
> > Also good.  We might want to keep b#, since there's no C way of doing
> > binary literals,
> 
> GCC supports "0b...", and it is proposed new ISO C syntax, too.

Ah, ok.  We should go with that instead, then.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
