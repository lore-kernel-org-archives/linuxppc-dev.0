Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: linuxppc_2_4_devel, rc1 and rc2 problem.
Date: Wed, 20 Nov 2002 19:55:35 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEECOFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021120160108.GJ779@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >
> > hmm, my i2c stuff got into rc2 (and uart too?). I see this on rc2 AND rc1, but NOT in pre8.
> > No, I have not tried to port it to vanilla 2.4.x. It requires some work to do that.
>
> They both made it in post rc1 I think, yes.  Try going back carefully
> via bk changes and bk export -tr1.xxxxx (find when
> /home/.../linuxppc_2_4 was merged into /home/.../linuxppc_2_4_devel).

The error ocurres between changeset 1.1130 - 1.1137.
I forgot to mention that the error only happens on a 862,100Mhz, 16KB icache, 8KB dcache.
My 860,80Mz does not show the problem.

Idea's ?

  Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
