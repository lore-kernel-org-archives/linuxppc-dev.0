Date: Fri, 23 Jun 2000 00:25:54 -0600 (MDT)
From: Jason Gunthorpe <jgg@ualberta.ca>
To: Frank Smith <smith@amirix.com>
cc: emdebian-discuss@lists.sourceforge.net, debian-devel@lists.debian.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded Debian Cross Development Environments Available
In-Reply-To: <00Jun22.220240adt.7304@dragon.appliedmicro.ns.ca>
Message-ID: <Pine.LNX.3.96.1000623001547.11519E-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Jun 2000, Frank Smith wrote:

> I'm pleased to announce the availability of the first *test* release of
> Embedded Debian Cross Development Environments. Here are the specs:

This is very interesting, I hope to have time to look at it myself later..
[I have ARM, m68k, and ppc boards to try] I found it a *HUGE* pain to get
a proper GCC/binutils/glibc/newlib cross compile setup, and I've done it 3
times now :<

You might also want to provide newlib versions of everything, it would be
really cool if you could share newlib/glibc gcc+binutils somehow.

For instance, for what I am doing now I need to be able to compile linux
kernels, compile linux applications, compile ecos and compile stand alone
programs. The latter two could really benifit from newlib availability.

>     * Capabilities:
>         - C development

C++ would be nice too, it is handy to use for embedded stuff. Don't
necessarily need libstdc++, just the compiler.

I really like how you re-used the libc6 .debs from the original sources,
that is certain to eliminate any possible incompatibilities. I have
regularly been cross compiling linux applications from i386 to ARM this
past little while, so this is important to me :>

In fact, a generic 'convert lib and lib-dev package to lib-TARGET' script
like alien would be extremely usefull, and probably quite doable!

Thanks,
Jason


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
