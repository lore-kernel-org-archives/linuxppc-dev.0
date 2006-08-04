Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17618.53692.364647.412406@cargo.ozlabs.ibm.com>
Date: Fri, 4 Aug 2006 14:49:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <20060803135440.GB3075@smtp.west.cox.net>
References: <3115459755319495cff4.1649760492.miltonm@bga.com>
	<20060803135440.GB3075@smtp.west.cox.net>
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

Tom Rini writes:

> But "content requirements change" isn't the same as "left things out of
> their tree".  It sounds, and I haven't seen the changes, so I'm not
> certain that the meaning behind a field changed.  Something like that
> should change the dt version.

I disagree.  Strongly.  The dt version relates to the representation
of the tree, not its content.

If we *have* to change the meaning of a property value in a particular
node in an incompatible way, then we can do something such as adding
another property to indicate what the interpretation of the first
property value should be.  Usually it's possible to find a way around
the problem without resorting to that, though.

>  New fields aren't a problem.  Changing
> existing fields meaning in incompatible ways is a problem.

Only a minor, localized problem.  Nothing worth changing the whole dt
version number for.

Paul.
