Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2350CDE1A7
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:29:04 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 16 Jul 2007 15:29:02 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <D0634B84-BD83-460E-AEC2-E8BB2837B237@kernel.crashing.org>
Message-ID: <20070716132902.118450@gmx.net>
MIME-Version: 1.0
References: <20070716075317.15260@gmx.net>
	<D0634B84-BD83-460E-AEC2-E8BB2837B237@kernel.crashing.org>
Subject: Re: Legacy ISA registers/interrupts in PCI device tree node
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
Datum: Mon, 16 Jul 2007 14:40:48 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org
Betreff: Re: Legacy ISA registers/interrupts in PCI device tree node

> > I wonder, if there is a recommended way to specify ISA register  
> > addresses and interrupts for a PCI device (unlike for a PCI2ISA
> > bridge)?
> 
> The PCI binding describes the required way to do this.
Hmm, I must reread the PCI binding spec. It didn't seem to contain any
information about this.

> Yes, it should, even if you don't use this in the Linux
> kernel yet.
Well, I still have to wire up the IDE interrupts in the platform setup
code, right?

Gerhard
-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
