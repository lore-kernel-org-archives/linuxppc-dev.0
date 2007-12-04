Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 09:12:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Message-ID: <20071204221209.GB2521@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<E1IzXmf-0005RJ-27@jdl.com>
	<20071204092611.79e08953@zod.rchland.ibm.com>
	<E38C9A55-77FC-46DE-AE30-A03A244656EB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E38C9A55-77FC-46DE-AE30-A03A244656EB@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 10:04:53AM -0600, Kumar Gala wrote:
> 
> On Dec 4, 2007, at 9:26 AM, Josh Boyer wrote:
> 
> > On Tue, 04 Dec 2007 07:25:57 -0600
> > Jon Loeliger <jdl@jdl.com> wrote:
> >
> >> So, like, the other day David Woodhouse mumbled:
> >>>
> >>> I think this is a bad idea -- it's hardly a difficult for those  
> >>> people
> >>> who _do_ need dts to obtain it separately.
> >>>
> >>> We shouldn't be merging _more_ stuff in.
> >>
> >> Thanks for chiming in here, David W.  As far as I can tell
> >> so far, the only two people who have voiced an opinion on
> >> this issue are Dave G, submitting patches, and me disagreeing
> >> with the approach.  :-)
> >>
> >> Anyone else?
> >
> > I don't see an overwhelmingly great reason to merge it.  It might help
> > test people who do automated rebuilds, etc and aren't used to dealing
> > with powerpc and it's requirements.  Outside of that, I see it as
> > dual-maintenance.
> >
> > But I'm not doing the maintenance, and it doesn't effect me too much.
> > I only ask that a decision is made and executed on soon so we can move
> > on.
> 
> I'm also in disagreement of duplicating dtc in the kernel.
> 
> However, if we are going to do this we should make the path expansion  
> for labels work before we do it.

Since we're going to have to update the in-kernel copy reasonably
frequently anyway, I don't see that there's much point in waiting for
particular features to be implemented.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
