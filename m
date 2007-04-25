Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FC4ADDF2C
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:03:33 +1000 (EST)
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug .org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:03:17 +1000
Message-Id: <1177459397.14873.160.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> While I realise your patch is just moving stuff around,
> can this be fixed please?  A missing "#address-cells"
> property means "two cells", not "inherit from parent".
> The few platforms with a broken tree should just be
> fixed (patch the tree in the bootwrapper, or perhaps
> _do_ use this workaround, but only on the affected
> platforms).

If you can get me access to all of the old PowerMac or CHRP crap with
broken device-tree's ...

Note that I don't think there's much cases of such breakage on the
field, but I'd be annoyed to change a behaviour we had from day 1.

> > +int of_n_size_cells(struct device_node *np)
> 
> Same here (the default is one cell though).

And same comment.

Ben.
