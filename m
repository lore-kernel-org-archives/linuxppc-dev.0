MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16563.7908.674693.831470@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 20:24:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Pantelis Antoniou" <panto@intracom.gr>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Kumar Gala" <kumar.gala@motorola.com>, "Wolfgang Denk" <wd@denx.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] Driver for FECs on motorola DUET (87x/88x)
In-Reply-To: <JPEALJAFNGDDLOPNDIEEAEMKCIAA.joakim.tjernlund@lumentis.se>
References: <16562.40219.697070.194257@cargo.ozlabs.ibm.com>
	<JPEALJAFNGDDLOPNDIEEAEMKCIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> I wonder if this applies to head.S also? I don't have a manual
> handy, but since the Alignment exceptions are identical, I guess
> that DAR & DSISR are also set for the CPUs that uses head.S?

No, the 6xx/7xx/7xxx processors only set SRR0/1 on a machine check.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
