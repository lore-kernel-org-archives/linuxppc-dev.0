From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Tom Rini" <trini@kernel.crashing.org>,
	"Dan Malek" <dan@embeddededge.com>, "Wolfgang Denk" <wd@denx.de>,
	<sanjeevr@myw.ltindia.com>
Subject: RE: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Fri, 14 May 2004 17:23:20 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEOEHHCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <40A4DC36.1000707@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: Pantelis Antoniou [mailto:panto@intracom.gr]
>
> Progress report.
>
> Got it to move even further.

Great!

>
> No longer crashes but it seems stuck in something related
> to the serial console.

If you are going to mess with the 8xx_io/uart.c, you might
want to port this from 2.4:
http://ppc.bkbits.net:8080/linuxppc-2.4/diffs/arch/ppc/8xx_io/uart.c@1.14.1.9?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/pp
c/8xx_io|hist/arch/ppc/8xx_io/uart.c


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
