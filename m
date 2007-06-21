Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D283BDDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 23:21:01 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 21 Jun 2007 15:20:59 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1182429406.24740.6.camel@localhost.localdomain>
Message-ID: <20070621132059.25900@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Thu, 21 Jun 2007 22:36:46 +1000
Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, list <linuxppc-dev@ozlabs.org>
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> You should have /pci/isa <--- this is the PCI2ISA bridge
> 
> and the ISA devices below that. Best is I send you an example of a CHRP
> or pSeries devie-tree with ISA stuff on it tomorrow. Ping me if I
> forget.
That would help a lot. Thank you!

> Haven't looked at your .dts yet but it should be "interrupt-controller",
> compatible "chrp,iic" or "i8259", with a #interrupt-cells of 2 and
> interrupts following the standard ISA encoding. You probably also want
> an interrupt-parent property in the isa bridge node pointing back to the
> 8259 so it becomes the default for all ISA devices.
What about PCI devices? Wouldn't it better to define the interrupt-parent property in the PCI bus node?

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
