Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 87A1ADDF1E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 07:09:44 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 06 Sep 2007 23:09:43 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <3acb0846724373a8f9edcf4650cc5455@kernel.crashing.org>
Message-ID: <20070906210943.299950@gmx.net>
MIME-Version: 1.0
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<3acb0846724373a8f9edcf4650cc5455@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
To: Segher Boessenkool <segher@kernel.crashing.org>
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
> Datum: Thu, 6 Sep 2007 15:36:30 +0200
> Von: Segher Boessenkool <segher@kernel.crashing.org>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
> Betreff: Re: [RFC] AmigaOne device tree source v2

> >> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
> >> PowerPC system bus.  So, it can not be mentioned in the "ranges"
> >> property, but the PHB registers used to access it should be shown
> >> in the "reg" property.  It could be a simple linear window (it
> >> sounds like it is here?), but it could for example also be implemented
> >> via an address/data register pair.
> > Yes, it is a simple linear address window. I'll remove its address 
> > range from the reg property.
> 
> No, please remove it from the "ranges" property, instead.
What about the PCI2ISA bridge? I map the first 64k PCI I/O address space
as ISA I/O space by using a ranges property. Would that be incorrect,
too?

Gerhard

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
