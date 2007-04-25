Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64EF9DDF1A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 11:43:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3P0gGkU021435
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 20:42:16 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3P1hPZf514968
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 21:43:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3P1hOaE001175
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 21:43:25 -0400
Date: Tue, 24 Apr 2007 20:51:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Message-ID: <20070425015123.GE23995@crusty.rchland.ibm.com>
References: <20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<1177459397.14873.160.camel@localhost.localdomain>
	<baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
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

On Wed, Apr 25, 2007 at 02:50:13AM +0200, Segher Boessenkool wrote:
> >> While I realise your patch is just moving stuff around,
> >> can this be fixed please?  A missing "#address-cells"
> >> property means "two cells", not "inherit from parent".
> >> The few platforms with a broken tree should just be
> >> fixed (patch the tree in the bootwrapper, or perhaps
> >> _do_ use this workaround, but only on the affected
> >> platforms).
> >
> > If you can get me access to all of the old PowerMac or CHRP crap with
> > broken device-tree's ...
> 
> No I can't, which is exactly why I cannot fix it myself.
> 
> > Note that I don't think there's much cases of such breakage on the
> > field,
> 
> For PowerPC it is mostly the G3 PowerMacs I believe.

I have one of those.  What exactly do you need from it?  I can probably do
some testing with it if needs be.

josh
