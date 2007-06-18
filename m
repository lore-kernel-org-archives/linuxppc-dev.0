Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 35F20DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 05:44:01 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 18 Jun 2007 21:43:59 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20070618191529.GC8740@mag.az.mvista.com>
Message-ID: <20070618194359.321010@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<20070618191529.GC8740@mag.az.mvista.com>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Mon, 18 Jun 2007 12:15:29 -0700
Von: "Mark A. Greer" <mgreer@mvista.com>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> On Mon, Jun 18, 2007 at 08:57:15PM +0200, Gerhard Pircher wrote:
> 
> > 1. The AmigaOne makes use of different G3...
> 
> I'm far from an authoritative figure on this but making a
> reasonable default (in your dts file) then updating in the 
> bootwrapper makes sense to me.  That's what I did for several 
> properties in the prpmc2800's dts.
So, the bootwrapper should update the name property of the CPU node. Is the cpu node name used somewhere?

> > If so, where should I specify the register address ranges (reg
> > property)? In the PCI device node or in the ISA device nodes,
> > as it is now?
> 
> Each device's node should have a reg property for its registers.
> You'll need a ranges property for the pci-isa bridge as well.
Ah yes, didn't think about that.

> P.S. You should change email clients of fix the one you're using
> to break lines up so they don't wrap in a std 80 char line 
> window.
Yeah, sorry. Forgot about that when writing the mail.

Gerhard
-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
