Date: Thu, 28 Mar 2002 00:16:11 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: slim kernel source
Message-ID: <20020328001611.S26309@plato.local.lan>
References: <20020327183028.71552.qmail@web11002.mail.yahoo.com>
Mime-Version: 1.0
In-Reply-To: <20020327183028.71552.qmail@web11002.mail.yahoo.com>; from dan_bethe@yahoo.com on Wed, Mar 27, 2002 at 10:30:28AM -0800
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 27, 2002 at 10:30:28AM -0800, Dan Bethe wrote:
>
> Hi all.  Is there a utility or procedure which can remove a bunch of the code
> from extraneous architectures from my kernel source tree?  I only want to build
> kernels for my beloved Powermac 8500 and so I can do without code specific to
> ia32, S390, Alpha, MIPS, and friends.
>
> Even if you just know of a few directories I can remove and save a couple dozen
> megs of space, that'd be good.

you can probably safly rm -rf everything under arch/* except arch/ppc
and include/asm-* except include/asm-ppc.  i haven't tried this but i
would expect this not to break anything (and if it does thats probably
a bug).

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
