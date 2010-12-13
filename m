Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 3DB551007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 19:35:07 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 08517-03 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 08:35:01 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC831x (and others?) NAND erase performance improvements
Date: Mon, 13 Dec 2010 08:33:37 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
In-Reply-To: <OF51D61C57.96435CC9-ONC12577F6.00326299-C12577F6.0032BA93@transmode.se>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"Scott Wood" <scottwood@freescale.com>
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > An external IRQ line would let you limit interrupts to rising edges
> > rather than all edges, though you'd lose the ability to=20
> > directly read the line status.
>=20
> oh, one cannot read the IRQ line? didn't know that. Also I not sure
> all Freescale CPUs can do rising edge.

I suspect that you may be able to leave the interupt masked, but still
read the 'interrupt pending' register. Which would have the same effect.

Our HW engineers tend to feed everything into an FPGA since it
gives than a lot more flexibility over pin connections.
In which case the invertor is trivial.
(and the fpga interface can read the status!)

	David
