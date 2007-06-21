Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0DE57DDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 23:28:53 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Thu, 21 Jun 2007 15:28:51 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1182429733.24740.12.camel@localhost.localdomain>
Message-ID: <20070621132851.25900@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>	
	<20070619054232.GB32039@localhost.localdomain>
	<1182429733.24740.12.camel@localhost.localdomain>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	david@gibson.dropbear.id.au
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
Datum: Thu, 21 Jun 2007 22:42:13 +1000
Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
An: David Gibson <david@gibson.dropbear.id.au>
CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org, list <linuxppc-dev@ozlabs.org>
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> > >               interrupt-controller;
> > >               reg = <20 2 a0 2 4d0 2>;
> > >               reserved-interrupts = <2>;
> 
> I'm currious about the above though, what is it ?

Quote from the CHRP ISA interrupt controller device binding document:
“reserved-interrupts”
Standard property name to define reserved interrupts.
prop-encoded-array: An integer array, encoded with encode-int.
The value of this property shall be a list of ISA interrupts which cannot
be assigned due to cascading, wiring, or other reasons. Only the irq# part
of the property is pertinent to this use.
- End -

> > >               #address-cells = <1>;
> 
> Why #address-cells set to 1 ? In a PIC node, in fact, I would expect it
> to be 0 to avoid any spurrious "reg" matching for interrupts.
Yeah, I got them wrong almost everywhere.

regards,

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
