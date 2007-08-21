Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 15:25:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Satya <satyakiran@gmail.com>
Subject: Re: Patches for ppc?
Message-ID: <20070821052514.GC21169@localhost.localdomain>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2007 at 06:28:50PM -0500, Satya wrote:
> hi,
> what's the issue with arch/ppc again? why is it being phased out? I
> am

It's a crusty, nasty, old codebase that we want to replace with the
newer and nicer arch/powerpc.

> working with the IBM Blue Gene/L which is based on ppc440. I need to
> get a patch in too! :)
> 
> I noticed that head_44x.S has been copied to arch/powerpc/kernel in
> the current head tree, but is it functional yet? has everything been
> moved to arch/powerpc ? how about the include files ?

It's not a question of indivudual files being copied over - things are
done differently in arch/powerpc.  Things are gradually being ported
over to arch/powerpc as people get the time - that's why arch/ppc
isn't gone yet.  440 support is now in arch/powerpc, but is not yet
complete:  it works, but is missing some fairly important device
support (RTC and PCI are the most prominent).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
