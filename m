Message-ID: <3CFE4F42.DDB1D5CE@mvista.com>
Date: Wed, 05 Jun 2002 10:49:54 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basics -- what tools for Walnut?
References: <3CFE4C3A.4070604@linuxfoundary.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

I suspect that is a fairly old tool chain that you are using.
Try modifying arch/ppc/Makefile to use

  -mcpu=403

instead of

  -mcpu=405

If you subscribe to the MontaVista product, the current compiler will
work properly with linuxppc_2_4_devel.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
