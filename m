From: Joe Green <jgreen@mvista.com>
To: greyham@research.canon.com.au (Graham Stoney)
Subject: Re: Journeyman configure/build options for gcc & glibc?
Date: Thu, 17 Aug 2000 08:02:59 -0700
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
References: <20000817031630.9089F238@elph.research.canon.com.au>
In-Reply-To: <20000817031630.9089F238@elph.research.canon.com.au>
MIME-Version: 1.0
Message-Id: <00081708261200.01481@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 16 Aug 2000, Graham Stoney wrote:
> I tried upgrading my root filesystem from Journeyman
> to 1.2, and now binaries built with my compiler work correctly with the HHL1.2
> libraries.  I never saw any varargs problems between my gcc-2.95.2 and
> glibc-2.1.3 once the other 8xx fixes were applied (the same ones that are
> now in the 1.2 SRPMs), so perhaps whatever got "fixed" in Journeyman was a bad
> mod that got backed out again for 1.2.
>
> Anyway, I'm happy.

OK, I'm glad to hear that.

>  My only gripe about the otherwise excellent Hard Hat kit
> is the ugly symlink from /opt/hardhat/devkit/ppc/8xx/powerpc-linux -> /
> which is necessary on the _target_.

Yes, we agree.  We actually have already fixed this, but it missed the
cutoff for the CDs; it was easy to fix, but was unfortunately overlooked
until too late.  It will be one of the first updates we post.

> (Well, actually I'm not thrilled with the gcc/cccp.c relocation hack either;
>  this sounds like a job for configure --prefix to me, but aside from that I'm
>  happy :-)

We have customers who want the installation location configurable at
install time.  gcc seems to be the only package that has a problem with
this.  I think we're working on a better solution for the next release.

> Keep up the good work!

Thanks
--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
