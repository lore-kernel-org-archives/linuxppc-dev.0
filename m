Date: Wed, 26 Sep 2001 18:20:11 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: Matt Porter <mporter@mvista.com>,
	"Prasad, Siva" <Siva.Prasad@smartm.com>,
	"'Tom Rini'" <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
Message-ID: <20010926182011.A25981@beef.az.mvista.com>
References: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com> <20010926125756.A28204@cx258813-a.chnd1.az.home.com> <3BB27710.68CBE18A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BB27710.68CBE18A@mvista.com>; from dan@mvista.com on Wed, Sep 26, 2001 at 08:47:12PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 26, 2001 at 08:47:12PM -0400, Dan Malek wrote:
> Matt Porter wrote:
>
> > Force's PowerBoot doesn't properly clean up caches before handing
> > control over to an external program.  You are probably having
> > cache problems that we have run into on some COTS Force boards.
> > I had to disable, flush, reenable L1 icache on the 680/G4, for
> > example.
>
> So, you are really running on luck then.  When you disable the

Absolutely, we are running on luck.

> cache, you are just fortunate that the necessary instructions
> to do the remainder of the work just happen to be in main memory,
> and that the cache was somehow implicitly invalidated so the ones
> you need to get to this point aren't stale in the cache.  Are
> you really sure the caches aren't cleaned up properly and this
> sequence of operations isn't masking some other problem?

I understand it's dangerous but it did limp around whatever the
root problem is.  It could be masking another problem...this
is a problem awaiting someone with time to understand it.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
