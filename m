Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03376DE0E2
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 18:33:09 +1000 (EST)
Subject: Re: pci32 code - early_*config*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
In-Reply-To: <c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
	<1239953159.7443.33.camel@pasglop>
	<c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 10:33:02 +0200
Message-Id: <1239957182.7443.58.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 10:03 +0200, Roderick Colenbrander wrote:
> 
> There are cases when it is really needed (or you would have to access
> the address and data bus by hand). In my case I'm using a Xilinx PLB
> soft-core and if certain options in the configuration header aren't
> set (which aren't set by default) the soft-core is basically disabled.
> Cases like this look like valid cases in which early config should be
> used.

I still wonder whether we could just setup the pci_controller data
structure and use "normal" PCI config access routines...

Cheers,
Ben.
