Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files 
In-Reply-To: Your message of "Mon, 17 Dec 2007 09:33:42 +1100."
	<20071216223342.GD26307@localhost.localdomain>
References: <1197705316-17618-1-git-send-email-sr@denx.de>
	<20071216061959.GD21311@localhost.localdomain>
	<20071216085858.55ffddbe@vader.jdub.homelinux.org>
	<f3ddb435a7a71cea8362ed73eb154200@kernel.crashing.org>
	<20071216223342.GD26307@localhost.localdomain>
Date: Mon, 17 Dec 2007 07:46:48 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J4GIy-0006Xp-RT@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> On Sun, Dec 16, 2007 at 07:10:02PM +0100, Segher Boessenkool wrote:
> > 
> > Hopefully some version that stores path strings in the properties
> > in /aliases, and not phandles.

Yes.

> > Or does that current version of DTC
> > do that correctly already, and just has an inconvenient source
> > syntax?

Feh.  If there is an "inconvenient source syntax", or any other
annoying irregularity, please, by all means, suggest improvements
and offer patches!

> I don't think anyone's actually gone and generated phandles in
> /aliases, although it was suggested early on.  The syntax is
> 	foo = < &bar >;
> to generate a phandle and
> 	foo = &bar;
> to generate a path.
> 
> I was a bit worried about confusion between these forms, but at least
> Kumar and myself came up with this syntax independently, which
> suggests it's not too surprising to most people, and no-one had any
> other suggestions.

To be a bit more complete, Kumar and I discussed this as well.

jdl
