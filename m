Return-Path: <jdl@jdl.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser. 
In-Reply-To: Your message of "Tue, 23 Oct 2007 16:41:51 +0200."
	<cace68e0fe3e4e257b7c63d18c805f18@kernel.crashing.org>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com>
	<cace68e0fe3e4e257b7c63d18c805f18@kernel.crashing.org>
Date: Tue, 23 Oct 2007 09:49:09 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IkL49-0006W4-8X@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> 
> >> And even without glr-parser, I'm still uncomfortable with the
> >> lexer<->parser execution ordering issues with the current
> >> /dts-version/ proposal.  It may now be true that the order is
> >> guaranteed to be correct, but it's still not exactly obvious.
> 
> If you require /dts-version/ (and similar global dtc-control stmts)
> to be at the start of the file, can't you avoid this ordering problem
> by starting to parse the file with a simple (hand-written) parser
> (which would handle these statements) and only when you cannot parse
> any more switch to the "normal" parser (which won't handle them)?
> Or is this a stupid suggestion :-)

My concern here is that I think we are attempting to make
this significantly more complex than it needs to be.
We have a pretty good KISS opportunity here, and I've shown
it to be working so far.  Longer term, all this cruft will
go away and it will become a moot point anyway.

jdl
