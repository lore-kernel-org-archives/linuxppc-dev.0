Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CFE4C3A.4070604@linuxfoundary.com>
Date: Wed, 05 Jun 2002 13:36:58 -0400
From: Dave Strout <dstrout@linuxfoundary.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Basics -- what tools for Walnut?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think I'm missing a basic concept here -- I'm about to do some work on
a Walnut system, so  I started by loading up the HardHat Linux that came
with the Walnut onto my intel desktop, then grabbing the
linuxppc_2_4_devel kernel via rsync.  When I try to compile, gas startes
to complain about "unknown option '-m405'".

I tried running /opt/hardhat/devkit/ppc/4xx/bin/ppc_4xx-as -m405, and
sure enough, it doesn't know the 405.  Nor does the gas that I built
from binutils 2.10.1 with --target-powerpc.

So, is there a patch I should be applying before building the
cross-compile environment, or a specific set of tools somewhere, or what
am I missing?

thanks,
dave.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
