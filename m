Date: Tue, 18 Jun 2002 07:51:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: 40x large page PTEs - Mark IV
Message-ID: <20020618145117.GF13541@opus.bloom.county>
References: <20020614060022.GB1124@zax> <20020618044003.GJ5238@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020618044003.GJ5238@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 18, 2002 at 02:40:03PM +1000, David Gibson wrote:
>
> On Fri, Jun 14, 2002 at 04:00:22PM +1000, David Gibson wrote:
> >
> > This version of the patch fixes a few compilation problems in the last
> > version when CONFIG_NOT_COHERENT_CACHE was not set.  I'm running it
> > now on my TiBook, and it works nicely on the 405GP machine.
>
> Ok, deathly silence.  Anyone who would object to this patch being
> pushed (to 2_4_devel) please raise their hands...

Well, how about 2.5 first? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
