Date: Wed, 26 Apr 2000 12:01:02 -0700
From: Matt Porter <mmporter@home.com>
To: Elizabeth Clarke <eclarke@aminocom.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc-2.1.2 cross-compile problem
Message-ID: <20000426120102.E27105@cx258813-a.chnd1.az.home.com>
References: <20000426002414.912D83C989@elph.research.canon.com.au> <3906FF25.4E9E6AEA@aminocom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3906FF25.4E9E6AEA@aminocom.com>; from eclarke@aminocom.com on Wed, Apr 26, 2000 at 02:37:25PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 26, 2000 at 02:37:25PM +0000, Elizabeth Clarke wrote:
>
> Graham Stoney wrote:
> >
> > Elizabeth Clarke writes:
> > > I'm having a problem compiling glibc-2.1.2 using the xppc
> > > cross-compilation toolset. I (believe I) have followed the instructions
> > > for patching glibc and all seemed fine, but I get the following, any help
> > > much appriciated!:
> >
> > Are you running gcc-2.95.2?
>
> I wasn't, but I grabbed it yesterday afternoon and been trying to
> compile it as per the instructions at
> http://members.home.net/mmporter/linux/cross/ which I found in your FAQ.
> I grabbed and compiled the latest binutils okay. But.... can't get gcc
> to compile. It took a little pursuading before it would use the
> new binutils, and now complains about stdio.h being missing:
>
> /usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
> -B/usr/local/powerpc-linux/bin/ -c -DHAVE_CONFIG_H -g -O2 -I.
> -I./../../include  choose-temp.c
> choose-temp.c:29: stdio.h: No such file or directory

Are you sure you followed the directions on my site?  You need to
configure your build of gcc with "--with-newlib" then link to your
kernel headers, then build glibc.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
