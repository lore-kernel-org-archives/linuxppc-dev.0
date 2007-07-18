Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F5CADDEC7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 23:54:06 +1000 (EST)
In-Reply-To: <20070717222507.GA4682@ld0162-tx32.am.freescale.net>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
	<1184707558.25235.159.camel@localhost.localdomain>
	<20070717222507.GA4682@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A86AB8AE-E421-457B-ABE8-9AD93CCFCDC8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Wed, 18 Jul 2007 15:53:54 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> See above. Besides, as I said, default values are crap. And no,  
>> it's not
>> obvious which nodes define a physical address space or not, at  
>> least not
>> for a generic parser.
>
> The obvious way (which indeed isn't what the suggested algorithm  
> does --
> but the suggested algorithm doesn't do anything sensible) is that  
> if you
> got to the node via an interrupt-parent or interrupt-map, it  
> doesn't use
> #address-cells, and if you got to it by going to the regular device  
> tree
> parent, it does.
>
> Pretty much any time you use the unit address in a context other  
> than the
> bus parent, things cease making sense.

Yes indeed.  The problem with your suggested "obvious way"
is that you wouldn't get a unit address included if your
interrupt-map points (for some entry) at your device tree
parent, either.  Not all that hypothetical.


Segher
