Date: Wed, 26 Mar 2003 08:57:52 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E810DA7.1060605@slac.stanford.edu>
To: Till Straumann <strauman@SLAC.Stanford.EDU>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEHGFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi guys.

Thanks Till, you are the first one who actually tested
my fix.

> I revitalized my old test environment on a
> mpc860t (XPC860TZP50B5 / 3J21M to be precise).

hmm, B5 rev is pretty buggy. Good that it works on
this silicon as well.

>
> I found that 'dcbz' (while failing to set DAR)
> indeed sets MD_EPN correctly. Hence, Jocke's fix
> (copy EPN[0:19]->DAR) would handle that.

Did you try any of the other dcxx instructions as well?

> My older idea (fixing up MD_EPN and DAR based
> on the faulting instruction opcode and the involved
> GPR contents) should work even if we have neither
> a valid MD_EPN nor DAR.

Yes, I tried to do that. I never got past how to convert the
virtual address in SRR0 to physical so I could read the instruction
and decode it.

>
> -- Till.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
