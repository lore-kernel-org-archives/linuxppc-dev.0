Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60EA667B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 22:03:29 +1000 (EST)
Subject: Re: PCIe enhanced configuration mechanism support on ppc arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <11BC5236-0411-402A-A3F1-0FB5E8059FA0@kernel.crashing.org>
References: <7cc604637892c0a00a5e3e38192494d7@bga.com>
	<1156978993.12526.97.camel@localhost.localdomain>
	<11BC5236-0411-402A-A3F1-0FB5E8059FA0@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 22:02:51 +1000
Message-Id: <1157025771.12526.133.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-31 at 12:11 +0200, Segher Boessenkool wrote:
> > An example of platform not using RTAS and that does support extended
> > config space is the PCI Express link out of the U4 northbridge on
> > PowerMac (though not the other PCIe slots connected to the HT<->PCIe
> > tunnel, at least not for now).
> >
> > It's basically just a matter of having your low level config access
> > routines supporting those >=256 offsets. The generic code tests  
> > that by
> > doing a dummy access and checks for an error return.
> 
> The U3/U4 HT config access code never returns the error though; it
> happily accesses the config space of the next device instead.  Got
> a patch, will send it later -- it's not a regression, there's no big
> hurry for 2.6.18.

Better to have it in if possible though. Thanks

Ben.
