From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Paul Mackerras" <paulus@samba.org>,
	"Dan Malek" <dan@embeddededge.com>
Cc: "Pantelis Antoniou" <panto@intracom.gr>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Kumar Gala" <kumar.gala@motorola.com>, "Wolfgang Denk" <wd@denx.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Tue, 25 May 2004 11:49:48 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEAEMKCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <16562.40219.697070.194257@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Given that the 860 manual says that the 860 sets DAR and DSISR on a
> machine check, I think Joakim's patch is desirable.  I assume other
> 8xx processors do also.
>
> Paul.

I wonder if this applies to head.S also? I don't have a manual
handy, but since the Alignment exceptions are identical, I guess
that DAR & DSISR are also set for the CPUs that uses head.S?

Currently only 8xx uses these in the machine check exception, but I
think the these registers should be accurate. They may be useful for
debugging if nothing else.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
