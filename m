Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A921CDDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 02:27:58 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 21 Jun 2007 18:27:57 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <5e4e419b28d588fa6ee40e2aeb93de2c@kernel.crashing.org>
Message-ID: <20070621162757.92930@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
	<20070621132059.25900@gmx.net>
	<5e4e419b28d588fa6ee40e2aeb93de2c@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Datum: Thu, 21 Jun 2007 16:38:49 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> Devices on a PCI bus have their interrupts encoded according
> to the PCI bus binding; this is a very much different format
> so you better have a real mapping (probably in the PCI host
> bridge) translating it to ISA interrupts (and pointing it there),
> if that's how the interrupts are routed on your box.
Ah, right. I have already seen that in a dts file, but didn't remember it.

> I hope this helps, it's a bit hard to explain without whiteboard :-)
For sure it helps!

Gerhard
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger
