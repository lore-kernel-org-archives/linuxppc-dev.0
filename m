Date: Fri, 14 May 2004 08:32:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>, Wolfgang Denk <wd@denx.de>,
	sanjeevr@myw.ltindia.com
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Message-ID: <20040514153232.GQ2196@smtp.west.cox.net>
References: <40A4DC36.1000707@intracom.gr> <JPEALJAFNGDDLOPNDIEEOEHHCIAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <JPEALJAFNGDDLOPNDIEEOEHHCIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 14, 2004 at 05:23:20PM +0200, Joakim Tjernlund wrote:

> > From: Pantelis Antoniou [mailto:panto@intracom.gr]
> >
> > Progress report.
> >
> > Got it to move even further.
>
> Great!
>
> >
> > No longer crashes but it seems stuck in something related
> > to the serial console.
>
> If you are going to mess with the 8xx_io/uart.c, you might
> want to port this from 2.4:
> http://ppc.bkbits.net:8080/linuxppc-2.4/diffs/arch/ppc/8xx_io/uart.c@1.14.1.9?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/pp
> c/8xx_io|hist/arch/ppc/8xx_io/uart.c

I'd prefer asking Kumar Gala for the re-written serial driver he did for
cpm2, and either copying that and making it work for cpm1 (8xx) or
adding cpm1 support cleanly into it.  I can provide an older, but
working on some variant of 2.4, serial driver vs the drivers/serial
infrastructure as well, if needed (I didn't write it, fwiw).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
