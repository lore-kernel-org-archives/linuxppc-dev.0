Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 09:33:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files
Message-ID: <20071216223342.GD26307@localhost.localdomain>
References: <1197705316-17618-1-git-send-email-sr@denx.de>
	<20071216061959.GD21311@localhost.localdomain>
	<20071216085858.55ffddbe@vader.jdub.homelinux.org>
	<f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 16, 2007 at 07:10:02PM +0100, Segher Boessenkool wrote:
> > Applied to my candidates tree.  Though I'd really like dtc to be merged
> > so that we can figure out what the in-kernel version will support.
> 
> Hopefully some version that stores path strings in the properties
> in /aliases, and not phandles.  Or does that current version of DTC
> do that correctly already, and just has an inconvenient source
> syntax?

I don't think anyone's actually gone and generated phandles in
/aliases, although it was suggested early on.  The syntax is
	foo = < &bar >;
to generate a phandle and
	foo = &bar;
to generate a path.

I was a bit worried about confusion between these forms, but at least
Kumar and myself came up with this syntax independently, which
suggests it's not too surprising to most people, and no-one had any
other suggestions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
