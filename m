Date: Tue, 25 Mar 2003 18:17:11 -0800
From: Till Straumann <strauman@SLAC.Stanford.EDU>
Subject: Re: dcbz works on 862 everywhere!
To: joakim.tjernlund@lumentis.se
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3E810DA7.1060605@slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
References: <IGEFJKJNHJDCBKALBJLLGEHAFLAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys.

I revitalized my old test environment on a
mpc860t (XPC860TZP50B5 / 3J21M to be precise).

I found that 'dcbz' (while failing to set DAR)
indeed sets MD_EPN correctly. Hence, Jocke's fix
(copy EPN[0:19]->DAR) would handle that.

My older idea (fixing up MD_EPN and DAR based
on the faulting instruction opcode and the involved
GPR contents) should work even if we have neither
a valid MD_EPN nor DAR.

-- Till.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
