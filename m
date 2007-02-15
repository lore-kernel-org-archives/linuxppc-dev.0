Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 09:12:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070215221244.GA19126@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BB35@az33exm25.fsl.freescale.net>
	<E1HHkym-0005u5-HA@jdl.com>
	<1171575883.5644.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171575883.5644.46.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 16, 2007 at 08:44:43AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-02-15 at 12:05 -0600, Jon Loeliger wrote:
> > So, like, the other day "Yoder Stuart-B08248" mumbled:
> > > 
> > > I like to see no space between the d#, h#, etc and the
> > > numeric value.
> > 
> > So, that's one of the really nice things about parsers.
> > Just do this, then:
> > 
> >     d23 = <d#23>;		// Just like <d# 23>!
> > 
> > The real question, though, is this:  MUST the space between
> > 'd#' and '23' be removed so that it is all one token?
> > I suppose I could repaint that shed if needed, but I 
> > don't think it is.
> 
> Also, the question is, will the d# affect only the next number or all
> the numbers until the next ">" ?

Only the next.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
