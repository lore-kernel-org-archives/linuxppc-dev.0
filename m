Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D0E07DA.327DF963@imc-berlin.de>
Date: Mon, 17 Jun 2002 18:01:30 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <20020617153255.GS13541@opus.bloom.county> <3D0E0253.A6A56B53@imc-berlin.de> <20020617154925.GT13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> > Ehm... Does that mean you won't accept patches vs linuxppc-2.4 though
> > !?!?
>
> That means I want this to be done in 2.5 first.  Where development is
> supposed to happen.  I have this feeling that fixing commproc.h will be
> more than 1 simple patch and we should do it in the development tree
> first.  Then, once that's all done and people are happy with it, we can
> move it to linuxppc_2_4.

Hmm... Just moving the DEFINEs from commproc.h to the board specific
header files is indeed just ONE simple patch. I've done that already. I
am not sure what else you mean by "fixing commproc.h"!?

The thing is:

Since I am sure that many, many people are still using linux-2.4.4 I
would realy like to fix that in linuxppc_2_4_devel, linux-2.4.4 (DENX)
_and_ PPCBoot at the same time! Just to keep that consistent.

And I have to admit that I haven't had a look at linuxppc-2.5 at all so
far... :-(

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
