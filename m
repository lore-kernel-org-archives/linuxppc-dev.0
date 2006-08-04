Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 40486679E7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 03:54:21 +1000 (EST)
Date: Fri, 4 Aug 2006 10:54:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060804175418.GA28095@smtp.west.cox.net>
References: <3115459755319495cff4.1649760492.miltonm@bga.com>
	<20060803135440.GB3075@smtp.west.cox.net>
	<17618.53692.364647.412406@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17618.53692.364647.412406@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2006 at 02:49:00PM +1000, Paul Mackerras wrote:
> Tom Rini writes:
> 
> > But "content requirements change" isn't the same as "left things out of
> > their tree".  It sounds, and I haven't seen the changes, so I'm not
> > certain that the meaning behind a field changed.  Something like that
> > should change the dt version.
> 
> I disagree.  Strongly.  The dt version relates to the representation
> of the tree, not its content.

But doesn't the representation include meaning?

> If we *have* to change the meaning of a property value in a particular
> node in an incompatible way, then we can do something such as adding
> another property to indicate what the interpretation of the first
> property value should be.  Usually it's possible to find a way around
> the problem without resorting to that, though.

Agreed.  Kicking myself for not being explicit enough :)

> >  New fields aren't a problem.  Changing
> > existing fields meaning in incompatible ways is a problem.
> 
> Only a minor, localized problem.  Nothing worth changing the whole dt
> version number for.

I'll rephrase what I said to what I think we all agree.  Changing
existing fields meanings in incompatible ways and not somehow allowing
that to still work (like by adding a flag so new trees are interpreted
one way, old trees are fixed-up or whatever) is a problem.

-- 
Tom Rini
