From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Pantelis Antoniou" <panto@intracom.gr>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar Gala" <kumar.gala@motorola.com>, "Wolfgang Denk" <wd@denx.de>,
	"Tom Rini" <trini@kernel.crashing.org>
Subject: RE: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Tue, 25 May 2004 14:29:04 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEECEMPCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <D50B7204-AE3C-11D8-B485-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On May 24, 2004, at 3:11 PM, Joakim Tjernlund wrote:
>
> > I do think there is something wrong in head_8xx.S. Check
> > http://lists.linuxppc.org/linuxppc-embedded/200405/msg00109.html
> > for details.
>
> Yes, that should be there but it doesn't prevent normal operation.
> It just causes a fatal error to print helpful information.

.. which is why I keep bugging you to add it. Useful error reporting
while debugging is a Good Thing.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
