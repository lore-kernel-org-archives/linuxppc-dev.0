Date: Tue, 10 Sep 2002 07:58:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107
Message-ID: <20020910145843.GB797@opus.bloom.county>
References: <1031581408.30396.81.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1031581408.30396.81.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 09, 2002 at 03:23:24PM +0100, Adrian Cox wrote:

> I've just been debugging an interesting problem with a new board that
> uses a MPC107 bridge with a 7445 processor. The symptoms were that the
> ethernet device never saw updated transmit descriptors unless another
> bus master was active in the system.
[snip]
> My current thinking is to produce a patch which introduces a new option:
> CONFIG_CACHING_HOSTBRIDGE which boards combining the MPC107 and the
> MPC7450 can set. This will probably be needed for Motorola's Valis or
> Gyrus PMCs.

Are there any more details you can give?  I've got a Sandpoint X3 and
Valis (with a 7455 CPU), and aside from the MPC107 Errata #18 problem
(http://e-www.motorola.com/brdata/PDFDB/docs/MPC107CE.pdf) which is now
fixed, I haven't seen any problems here.  Do you have access to this
board and a 7455?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
