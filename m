Date: Tue, 25 May 2004 07:40:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>, akpm@osdl.org,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] MachineCheck exception broken for MPC 8xx CPU's
Message-ID: <20040525144030.GX6763@smtp.west.cox.net>
References: <JPEALJAFNGDDLOPNDIEEMEMICIAA.joakim.tjernlund@lumentis.se> <16563.7471.661845.182333@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16563.7471.661845.182333@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 25, 2004 at 08:17:19PM +1000, Paul Mackerras wrote:

> Joakim Tjernlund writes:
>
> > The Machine Check exception handler is broken on MPC 8xx CPU's
> > This patch should fix it.
> > Tom Rini asked me to send it to you.
>
> Hmmm, this doesn't look like it will apply.  The patch looks to be
> against linuxppc-2.5, not Andrew's/Linus' tree.
>
> In fact I don't think there is a great deal of point in applying this
> patch until we update arch/ppc/kernel/head_8xx.S with all the other
> changes we have in the linuxppc-2.5 tree.

Aside from one less thing to pull out and push ahead?  I was hoping to
avoid exactly that if possible. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
