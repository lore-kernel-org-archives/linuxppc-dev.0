Date: Wed, 19 Jun 2002 11:11:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: 40x large page PTEs - Mark IV
Message-ID: <20020619011155.GH15985@zax>
References: <20020614060022.GB1124@zax> <20020618044003.GJ5238@zax> <20020618145117.GF13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020618145117.GF13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 18, 2002 at 07:51:17AM -0700, Tom Rini wrote:
>
> On Tue, Jun 18, 2002 at 02:40:03PM +1000, David Gibson wrote:
> >
> > On Fri, Jun 14, 2002 at 04:00:22PM +1000, David Gibson wrote:
> > >
> > > This version of the patch fixes a few compilation problems in the last
> > > version when CONFIG_NOT_COHERENT_CACHE was not set.  I'm running it
> > > now on my TiBook, and it works nicely on the 405GP machine.
> >
> > Ok, deathly silence.  Anyone who would object to this patch being
> > pushed (to 2_4_devel) please raise their hands...
>
> Well, how about 2.5 first? :)

Ok... I agree that we should be doing more experimentation in 2.5.  In
2.5 I'm waiting on paulus to apply (or reject) a couple of preliminary
cleanups to mapin_ram() and friends.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
