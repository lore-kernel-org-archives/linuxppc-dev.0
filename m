Date: Mon, 12 Nov 2001 20:04:17 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <3BF013E3.52F45AE9@mvista.com>
Message-ID: <Pine.GSO.3.96.1011112195657.24771N-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Nov 2001, Jun Sun wrote:

> >  OK, then you need an RTC chipset-specific driver and not a CPU
> > architecture-specific one.
>
> You *can* write a chip specific driver in addition to this generic one if you
> want.  Presumably the chip-specific one provides more operations than just
> read/write date.

 Then why make this driver MIPS-specific?

> > Otherwise we'll end with a zillion of similar
> > RTC drivers like we already have for LANCE and SCC chips.
>
> Don't quite understand this statement.

 This assumed you've meant an MC146818 RTC that already has a driver for
certain (but possibly not all) configurations.  Since you haven't -- just
forget it.

--
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
