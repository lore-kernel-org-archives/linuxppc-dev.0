Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 2 May 2007 19:55:16 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/13] powerpc: Add arch/powerpc interrupt handler for
	mv64x60
Message-ID: <20070503025515.GA26019@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235858.GH4046@mag.az.mvista.com>
	<20070502213830.GA27253@xyzzy.farnsworth.org>
	<20070503114705.a8f305ec.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070503114705.a8f305ec.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 11:47:05AM +1000, Stephen Rothwell wrote:
> On Wed, 2 May 2007 14:38:30 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
> >
> > +DEFINE_SPINLOCK(mv64x60_lock);
> 
> Does this need to be global (it is not declared in the header file)?

No, it doesn't.  I made it static.

> > +static u32 mv64x60_cached_low_mask  = 0;
> > +static u32 mv64x60_cached_high_mask = MV64X60_HIGH_GPP_GROUPS;
> > +static u32 mv64x60_cached_gpp_mask  = 0;
> 
> Don't initialise things to zero, please.  If you feel it is necessary,
> put the "= 0" in a comment.  But generally we know that globals are
> initially zero.

OK.  Thanks.

-Dale
