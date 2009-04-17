Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDEC7DE08A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:05:21 +1000 (EST)
Subject: Re: pci32 code - early_*config*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5A611DAC-A7E2-4E96-A087-B9BFD8DF59F9@kernel.crashing.org>
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
	<1239953159.7443.33.camel@pasglop>
	<c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
	<1239957182.7443.58.camel@pasglop>
	<5A611DAC-A7E2-4E96-A087-B9BFD8DF59F9@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 19:05:12 +0200
Message-Id: <1239987912.7210.17.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 09:08 -0500, Kumar Gala wrote:
> The problem is that the "normal" PCI config access routines need a  
> pci_bus.  However we don't have one yet and we need to do PCI config  
> cycles to the PHB before we call the remainder of the setup code to  
> get one.
> 
> We could all call our own ops directly and provide a fake bus but
> this  
> is pretty much what the early routines do for us in a common way.

Ah right, slipped out of my mind. Oh well, easy to make the code
common, move it to pci-common.c

Cheers,
Ben.
