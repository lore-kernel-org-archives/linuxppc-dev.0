Subject: Re: 64-bit user-space on G5? Never, soonish, or unknown?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <16426.14204.974363.611192@alkaid.it.uu.se>
References: <16426.14204.974363.611192@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1076537642.866.127.camel@gaston>
Mime-Version: 1.0
Date: Thu, 12 Feb 2004 09:14:02 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-02-12 at 01:09, Mikael Pettersson wrote:
> We're considering buying a G5 for porting a compiler/runtime-system
> project to PPC and eventually PPC64.
>
> The question is, will Linux ever support a 64-bit user-space
> on the G5? From my reading of arch/ppc and arch/ppc64, the
> differences seem major so I'm not holding my breath, but perhaps
> there is hope.
>
> Or should we just treat the G5 as a faster 32-bitter?
>
> Or should we use some other OS than Linux :-(

There is a 64 bits kernel for the G5, it's currently available
on YDL site, though I'll have the whole thing merged with Linus in
a few days (with some luck, 2.6.3 will boot out of the box on those
in both 32 bits and 64 bits versions).

I don't know of a distro that offer 64 bits userland yet, YDL is
working on a bi-arch setup, there are SuSE and RedHat distros for
IBM p/iSeries though those don't support G5s at the moment, but it
may just be a matter of using the right kernel with them and maybe
tweaking the installer...

And you can always build your own toolchain & glibc :)

The 64 bits kernel allow you to run both 32 and 64 bits userland,
the common practice is to have a 32 bit userland with the necessary
libs to be able to build & run _some_ 64 bits executables.

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
