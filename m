Date: Tue, 08 Apr 2003 18:42:30 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <3E92F80C.1020409@slac.stanford.edu>
To: Till Straumann <strauman@slac.stanford.edu>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCENJFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> Why not tag MD_EPN with an unused CASID?

That won't work, will it? Your test report said that the CASID
bits were set/reset by dcbi and dcbz? Did I missunderstand something?

Also, the tagging procedure will require more than 2 instructions, I think.

I tried to use the VALID bit in MD_EPN, but that does not work.

One thing I noticed is that I can remove M_CASID and M_EVALID copy in the DTLB Error
handler without any visible problems. Why are they needed?

 Jocke
>
> -- Till


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
