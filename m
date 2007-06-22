Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A5658DDE33
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:12:02 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 22 Jun 2007 15:12:01 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1182468169.24740.15.camel@localhost.localdomain>
Message-ID: <20070622131201.313400@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>	
	<1182429406.24740.6.camel@localhost.localdomain>	
	<20070621132059.25900@gmx.net>
	<1182468169.24740.15.camel@localhost.localdomain>
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
Datum: Fri, 22 Jun 2007 09:22:49 +1000
Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> Do you have the recommended practice "interrupt mapping" standard ?
Yes, downloaded it right now.

> It also allowed to make it optional to have nodes for the PCI devices in
> slots, you can provide the mapping of all 4 INT# lines in the bridge
> node and linux can use it when probing for devices, so your bootwrapper
> doesn't have to know what's in the slots and doesn't have to create
> device nodes for those.
I would like to have PCI nodes only for the PCI host and PCI2ISA bridge.
The interrupt mapping of the INT# lines can be configured within U-boot,
thus I would avoid to specify it somewhere in the device tree, if it isn't
really necessary.

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
