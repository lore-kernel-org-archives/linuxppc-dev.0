Date: Fri, 16 Jul 2004 19:40:49 +1000
From: Rob Weir <rweir@ertius.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk oops(?) on g4 ibook
Message-ID: <20040716094049.GC4608@ooder.ertius.org>
References: <20040701041703.GH27929@ooder.ertius.org> <20040716074152.GC3698@bogon.ms20.nix> <20040716082310.GB4608@ooder.ertius.org> <20040716092003.GE3698@bogon.ms20.nix>
Mime-Version: 1.0
In-Reply-To: <20040716092003.GE3698@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 2004 at 11:20:04AM +0200, Guido Guenther said
> On Fri, Jul 16, 2004 at 06:23:10PM +1000, Rob Weir wrote:
> > On Fri, Jul 16, 2004 at 09:41:52AM +0200, Guido Guenther said
> > > On Thu, Jul 01, 2004 at 02:17:03PM +1000, Rob Weir wrote:
> > > > I've been using Guido's pmdisk patch with...a fair amount
> > > > of success, but it occasionally oopses on resume (even with
> > > > USB/dmasound/therm_adt746x modules unloaded), and fairly often
> > >
> > > Hmm...I've never seen this. I'll have a look.
> >
> > Everytime I've resumed in the past week I've got an oops, then
> > a series of "out of memory" errors while things like hotplug
> > restart...would it be useful I wrote this oops down by hand?
>
> It wouldn't hurt. Are they all the same?

They all...look similar, but I've never written them down so I'm not
sure.  It starts with a "order-0 allocation failure" or so, then
programs start failing to allocate memory, too.  I'll write it down next
time it happens (I've taken to just shutting down when moving it, since
this happens so often).

> Since when exactly does this happen?

On most resumes.

> Did you change anything since then?

I do a dist-upgrade against sid every few days, but I haven't changed
the kernel in weeks.  Hm...I'm using your 2.6.7-rc3 pmdisk patch against
2.6.7 itself, maybe I should just update to your 2.6.7 one and 2.6.8-rcX
before bothering you further...

--
Words of the day:         diwn clones CDC SSL AMEMB 22nd SAS colonel cypher=
punk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
