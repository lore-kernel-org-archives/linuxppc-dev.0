Return-Path: <michael@ellerman.id.au>
Date: Tue, 16 Apr 2013 18:33:11 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: remove section changes from _GLOBAL() and
 friends
Message-ID: <20130416083311.GA935@concordia>
References: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
 <20130415120016.GB12701@concordia>
 <20130415233040.ca38e79ce08c519554baa865@canb.auug.org.au>
 <20130416021747.a9608ca92eb68495493e061b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130416021747.a9608ca92eb68495493e061b@canb.auug.org.au>
Cc: Alan Modra <amodra@au1.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 16, 2013 at 02:17:47AM +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Mon, 15 Apr 2013 23:30:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 15 Apr 2013 22:00:17 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> > >
> > > On Thu, Nov 29, 2012 at 10:55:25AM +1100, Stephen Rothwell wrote:
> > > > These sometimes produce unexpected results and make it hard to put the
> > > > start up code (for 64 bit) into the .head.text section.
> > > 
> > > ...
> > > 
> > > > diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> > > > index 6f62a73..4ec5625 100644
> > > > --- a/arch/powerpc/kernel/head_fsl_booke.S
> > > > +++ b/arch/powerpc/kernel/head_fsl_booke.S
> > > > @@ -776,6 +776,8 @@ tlb_write_entry:
> > > >  	mfspr	r10, SPRN_SPRG_RSCRATCH0
> > > >  	rfi					/* Force context change */
> > > >  
> > > > +	,text
> > > > +
> > > 
> > > I'm assuming this should be .text ?
> > 
> > Indeed.  Oops :-)
> 
> BTW, those patches are almost certainly stale by now and would need to be
> redone before be included on the kernel proper.

Now you tell me. It's in my tree, and building, but potentially missing
some .text annotations I guess. I'll rip it out until you send me a new
version.

cheers
