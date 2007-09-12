Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Sep 2007 12:03:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: FDT for Microblaze and PPC405
Message-ID: <20070912020339.GC16001@localhost.localdomain>
References: <fa686aa40709110901k11082946r626fc8532d47eab5@mail.gmail.com>
	<2057.3992-23959-31980099-1189527824@seznam.cz>
	<fa686aa40709111009j64925edag511078d88ff904c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40709111009j64925edag511078d88ff904c@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michal Simek <Monstr@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 11:09:07AM -0600, Grant Likely wrote:
> On 9/11/07, Michal Simek <Monstr@seznam.cz> wrote:
> > For example emaclite driver needs information about turning on/off ping pong buffer...
> >
> > I would like to make this properly.
> 
> FDT design is just as much art as it is science.  It takes taste and
> judgement to desgin a nice set of bindings.  Your best option is to
> draft something and post it to the linuxppc-embedded mailing list for
> review.

Yes, this is the preferred procedure, for now.

> > And second question is on early console logs and timers setting. I read about aliases in FDT. I think that aliases can cover this setting.
> > For example my design contain 4 serial line and I would like to know which serial line is set on early console.
> 
> You use the chosen node for this.  In the chosen node, you add a
> property called "linux,stdout-path" which holds the path to your
> console.  You can look at examples under arch/powerpc/boot/dts/*

Yes.  Currently we don't use /aliases in the flat device tree.  This
is possibly a mistake, and something I'm thinking about changing.
But, for now, linux,stdout-path in /chosen is the way to do this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
