Message-ID: <3CFE4DD0.7FC2E7BF@mvista.com>
Date: Wed, 05 Jun 2002 12:43:44 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basics -- what tools for Walnut?
References: <3CFE4C3A.4070604@linuxfoundary.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The version of HardHat Linux that came with your walnut was created to match the
requirements of the kernel also shipped with Hard Hat Linux.

The current _devel kernel requires a newer version of binutils that understands
the -m405 architecture.  Either use the kernel shipped w/ Hard Hat Linux, or you
will need to get a newer tool chain.  (Either build it yourself or purchase it
from MontaVista...)

--Mark
(Speaking for myself, not MontaVista whom I work for.)

Dave Strout wrote:
>
> I think I'm missing a basic concept here -- I'm about to do some work on
> a Walnut system, so  I started by loading up the HardHat Linux that came
> with the Walnut onto my intel desktop, then grabbing the
> linuxppc_2_4_devel kernel via rsync.  When I try to compile, gas startes
> to complain about "unknown option '-m405'".
>
> I tried running /opt/hardhat/devkit/ppc/4xx/bin/ppc_4xx-as -m405, and
> sure enough, it doesn't know the 405.  Nor does the gas that I built
> from binutils 2.10.1 with --target-powerpc.
>
> So, is there a patch I should be applying before building the
> cross-compile environment, or a specific set of tools somewhere, or what
> am I missing?
>
> thanks,
> dave.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
