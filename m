From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 10 Nov 2003 12:09:21 -0700
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031110190921.GB12163@zenos.farnsworth.org>
References: <20031103233143.GA19177@zenos.farnsworth.org> <20031107222025.3181CC5F59@atlas.denx.de> <20031110162536.GC8584@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031110162536.GC8584@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 10, 2003 at 04:25:36PM +0000, Tom Rini wrote:
> Speaking of the FEC code, someone should run one version (and for the
> moment, I vote for Wolfgang's version) past Jeff Garzik to see what he
> thinks.

The version contained in
ftp://source.mvista.com/pub/linuxppc/mpc5200/linuxppc_2_4_devel.mpc5200.patch
is a bit cleaner, since many ifdefs for mgt5100 support have been removed.
It could stand quite a bit of cleanup, but I'll ask Jeff to take a look.

> > > so ethernet isn't quite working again, yet.  I've made several changes
> > > to the 5200 port as well.
> > >
> > > I will post my updated code to this list this week and would prefer
> > > to see it merged rather than my older code contained in the above patch.
> >
> > The code I submitted contains some things; some code was developed by
> > BenH, some by DENX. It would be sad if this stuff was  just  ignored.
> > How about merging our code and your new stuff?
>
> I concur that it would be best to try and merge these two versions back
> together.

See my attempt at the above url.

Thanks,
-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
