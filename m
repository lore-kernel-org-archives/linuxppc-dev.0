Date: Fri, 23 Jan 2004 19:54:33 +0100
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: chrp mmu and booting.
Message-ID: <20040123185433.GB5125@iliana>
References: <20040123111725.GB23537@iliana> <1074883450.2842.9.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074883450.2842.9.camel@otta.rchland.ibm.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 23, 2004 at 12:44:10PM -0600, Peter Bergner wrote:
> On Fri, 2004-01-23 at 05:17, Sven Luther wrote:
> > Now, does this mean that the chrp of does enable the mmu before booting,
> > and does program it in a way so that the translate (0) call will result
> > in 0x10000, or do i miss something ?
>
> On IBM CHRP hardware, OF executes in real mode (ie, relocate off).  It
> then branches to yaboot/kernel still in real mode.  It's not until a
> fair ways into the kernel boot that we turn relocate on (after we're
> done making calls to OF).  This also means that Yaboot executes in
> real mode as well on IBM CHRP machines.

Yeah, but in my case, i have no yaboot, and i know that these boxes are
also capable of booting from the OF.

But then, how comes the OF translate call is able to map the address 0
to the 0x10000 address ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
