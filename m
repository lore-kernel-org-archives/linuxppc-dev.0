Date: Fri, 25 Oct 2002 18:39:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PrPMC800 interrupt problem
Message-ID: <20021026013909.GD30713@opus.bloom.county>
References: <20021025160001.GB30713@opus.bloom.county> <BC199E78-E838-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BC199E78-E838-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 25, 2002 at 06:42:22PM +0200, Anders Blomdell wrote:

> >What you're suggesting brings back the old hacking behavior.  Again I
> >say, look at what lopec_setup.c does for handling interrupts, look at
> >the manual for the prpmc800 (and the MPC107 (OpenPIC/EPIC related bits)
> >or MPC8240 (again, OpenPIC/EPIC)) manuals.
>
> OK, hope this is a correct solution then (it works, which is a good thing)
> . Thanks for your patience, all the levels in the interrupt handling are a
> bit hairy to understand.

This looks much better, I will commit this monday.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
