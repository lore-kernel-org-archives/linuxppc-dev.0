From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Paul Mackerras" <paulus@samba.org>
Cc: <akpm@osdl.org>, "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] MachineCheck exception broken for MPC 8xx CPU's
Date: Tue, 25 May 2004 12:26:45 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEIEMLCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <16563.7471.661845.182333@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > The Machine Check exception handler is broken on MPC 8xx CPU's
> > This patch should fix it.
> > Tom Rini asked me to send it to you.
>
> Hmmm, this doesn't look like it will apply.  The patch looks to be
> against linuxppc-2.5, not Andrew's/Linus' tree.

OOPS, I did not think. You are correct, this is against current linuxppc-2.5.

>
> In fact I don't think there is a great deal of point in applying this
> patch until we update arch/ppc/kernel/head_8xx.S with all the other
> changes we have in the linuxppc-2.5 tree.

Can you apply this to linuxppc-2.5 then?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
