Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 16:19:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Message-ID: <20070214051924.GA12609@localhost.localdomain>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D29AE5.7090004@freescale.com>
Cc: paulus@samba.org, Stuart Yoder <stuart.yoder@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 11:15:17PM -0600, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
> > I think that:
> > 
> >  - The /chosen node should be present in the .dts even if empty
> 
> Only one DTS file has it.  It's been removed from every other DTS.  Are 
> you should that instead of removing the last one, I should *add* one to 
> the other DTS files?
> 
> >  - I don't see why you are removing linux,boot-cpu from the
> > documentation ! It's a fairly important property. 
> 
> No, it's a dead property.  Specifying linux,boot-cpu in the DTS is 
> obsolete and deprecated.  If you specify it, the device tree compiler 
> complains.  The proper way to specify the device tree is with the -b 
> parameter to dtc.

Um.. you may be right in this case, but "the device tree compiler
complains" is (sadly) not in general a good reason to decide
something's bad.  The warning code in dtc is pretty bogus and
complains about a number of things it shouldn't while failing to
complain about some things it should.  I just haven't had time to make
it much better.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
