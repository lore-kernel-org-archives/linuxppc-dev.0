Date: Fri, 11 May 2001 18:25:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christiaan Welvaart <C.J.Welvaart@phys.uu.nl>
Cc: bj93543@binghamton.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: swim3 + ide-floppy devfs patch (was Re: Q: devfs and swim3)
Message-ID: <20010511182506.R30868@opus.bloom.county>
References: <Pine.GSO.BU-L4.10.10103022135250.25059-100000@bingsun2> <Pine.OSF.4.33.0103282255180.22208-100000@ruunat.phys.uu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.OSF.4.33.0103282255180.22208-100000@ruunat.phys.uu.nl>; from C.J.Welvaart@phys.uu.nl on Wed, Mar 28, 2001 at 11:19:52PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 28, 2001 at 11:19:52PM +0200, Christiaan Welvaart wrote:
>
> On Fri, 2 Mar 2001 bj93543@binghamton.edu wrote:
>
> > Is there known any reason why swim3 floppy controler is not inserted
> > in devfs ?
> > or can be swim3.c patched like:
> >
> > -swim3.c:1034:  ...register_blkdev...
> > +swim3.c:1034:  ...devfs_register_blkdev...
>
> This is not enough, it just prevents the floppy driver to be registered if
> you tell devfs to not use the old-style device system with major/minor
> numbers I believe. Below a patch that seems to work, though I'm not sure
> if the permissions are right. I also included a patch for ide-floppy since
> my zip drive was missing from devfs as well. That one should probably be
> sent to the regular linux-kernel list though.

[I ment to do something about this sooner, really].
I've applied the swim3 patch to the 2_4 bk tree, so this should propogate
eventually.  The ide-floppy one really should goto l-k or better yet the
IDE maintainer.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
