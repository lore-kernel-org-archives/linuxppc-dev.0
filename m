Date: Tue, 08 Apr 2003 18:52:20 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <3E92F80C.1020409@slac.stanford.edu>
To: Till Straumann <strauman@slac.stanford.edu>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOENJFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again

I am wonder if it is possible to reduce the number of instructions in:

  mfspr r20, DAR
  lis   r21, 0xdead
  cmpw  cr0, r20, r21
  beq-  100f

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
