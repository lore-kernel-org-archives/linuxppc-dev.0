Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 1 Oct 2003 16:51:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20031001235158.GD17768@ip68-0-152-218.tc.ph.cox.net>
References: <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com> <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net> <1065019736.9737.526.camel@hermes> <005801c38861$e7a596a0$020120b0@jockeXP> <20031001213239.GA17768@ip68-0-152-218.tc.ph.cox.net> <006001c38866$3017e560$020120b0@jockeXP> <20031001220048.GB17768@ip68-0-152-218.tc.ph.cox.net> <007a01c38869$c2287200$020120b0@jockeXP> <20031001223156.GC17768@ip68-0-152-218.tc.ph.cox.net> <3F7B61EF.1030306@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F7B61EF.1030306@tait.co.nz>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 02, 2003 at 11:23:27AM +1200, Robin Gilks wrote:

> Tom Rini wrote:
> >On Thu, Oct 02, 2003 at 12:17:10AM +0200, Joakim Tjernlund wrote:
> >
> >>>>>It's in the linuxppc-2.4 tree.  I'll try and get it to Marcelo in time
> >>>>>for 2.4.21-pre7.
> >>>>
> >>>>Ahh, found it in http://ppc.bkbits.net:8080/linuxppc-2.4. I did look in
> >>>>http://ppc.bitkeeper.com:8080/linuxppc_2_4 but it is not there. Is this
> >>>>tree obsolete?
> >>>
> >>>It's not preferred, certainly.
> >>
> >>What about linuxppc_2_4_devel? Is that also "non preferred"?
> >
> >
> >Yes.
>
> Rather than lots of URLs that are NOT recommended, is there one that is?

For the moment it's "whatever you have now is probably fine".  For
2.4.23 I would like to get most of _devel cleaned out, wrt 8xx.  This
will probably leave out some 'new' boards that Wolfgang sent out a long
time ago (FWIW, once I get everything else out I do plan to ask Wolfgang
if he wants to re-submit those boards or verify there's nothing new
needed to what's in _devel or something).

If you have a new board, or a bug fix, current kernel.org (BK, snapshots
of BK, just official releases) is best.


> Also, you refer to 2.4.21-pre but I thought we had moved onto 2.4.23-pre
> now. Is the ppc tree really that much out-of-date?

Whoops, yes, 2.4.23-pre.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
