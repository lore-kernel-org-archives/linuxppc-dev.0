MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16563.7471.661845.182333@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 20:17:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Cc: <akpm@osdl.org>, "Tom Rini" <trini@kernel.crashing.org>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] MachineCheck exception broken for MPC 8xx CPU's
In-Reply-To: <JPEALJAFNGDDLOPNDIEEMEMICIAA.joakim.tjernlund@lumentis.se>
References: <JPEALJAFNGDDLOPNDIEEMEMICIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> The Machine Check exception handler is broken on MPC 8xx CPU's
> This patch should fix it.
> Tom Rini asked me to send it to you.

Hmmm, this doesn't look like it will apply.  The patch looks to be
against linuxppc-2.5, not Andrew's/Linus' tree.

In fact I don't think there is a great deal of point in applying this
patch until we update arch/ppc/kernel/head_8xx.S with all the other
changes we have in the linuxppc-2.5 tree.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
