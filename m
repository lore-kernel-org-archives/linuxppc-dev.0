Date: Tue, 26 Jun 2001 15:43:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
Message-ID: <20010626154344.H31231@opus.bloom.county>
References: <20010626121003.D31231@opus.bloom.county> <20010626205147.26310@smtp.wanadoo.fr> <20010626162913.3dc483d8.toe@unlserve.unl.edu> <20010626151346.F31231@opus.bloom.county> <20010626173123.13f2b3bf.toe@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010626173123.13f2b3bf.toe@unlserve.unl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 26, 2001 at 05:31:23PM -0500, Takashi Oe wrote:
> On Tue, 26 Jun 2001 15:13:46 -0700, Tom Rini wrote:
>
> > On Tue, Jun 26, 2001 at 04:29:13PM -0500, Takashi Oe wrote:
> >
> > > BootX support on your rsync tree and linuxppc_2_4_devel tree is
> > > broken.  I guess no one with BootX bothered to try
> > > linuxppc_2_4_devel..
> >
> > Does this work as well?
>
> It sure does, though we might as well do:
[snip]
> or similar as calling intuit_machine_type() is silly on BootX ;)

True enough.  I just pushed that.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
