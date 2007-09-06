Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E9F9EDDF17
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 06:51:39 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 06 Sep 2007 22:51:37 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070906141501.GA16353@ld0162-tx32.am.freescale.net>
Message-ID: <20070906205137.299990@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
	<20070906141501.GA16353@ld0162-tx32.am.freescale.net>
Subject: Re: PCI I/O space -- reg or ranges?
To: Scott Wood <scottwood@freescale.com>, segher@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 6 Sep 2007 09:15:01 -0500
> Von: Scott Wood <scottwood@freescale.com>
> An: Segher Boessenkool <segher@kernel.crashing.org>
> CC: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
> Betreff: PCI I/O space -- reg or ranges?

> > Sure, it can be encoded like that.  But does it make sense?
> > You cannot use legacy I/O space as normal memory space.
> 
> Why does it not make sense?  I'm not sure what you mean by using it as
> "normal memory space", but if the PCI bridge does a straightforward
> linear mapping of I/O into memory space (like most non-x86 bridges do),
> it seems to make sense to me to reuse the existing ranges mechanism
> rather than require each driver to have extra glue code.
Well, pci_process_bridge_OF_ranges() only looks at the ranges property to
ioremap() I/O space.

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
