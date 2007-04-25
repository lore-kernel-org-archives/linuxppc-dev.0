Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D551DDF36
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 12:07:41 +1000 (EST)
In-Reply-To: <20070425015123.GE23995@crusty.rchland.ibm.com>
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
	<20070425015123.GE23995@crusty.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <132ba09392e295d8594d97ed5e6e0323@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Wed, 25 Apr 2007 04:07:34 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
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

>>> If you can get me access to all of the old PowerMac or CHRP crap with
>>> broken device-tree's ...
>>
>> No I can't, which is exactly why I cannot fix it myself.
>>
>>> Note that I don't think there's much cases of such breakage on the
>>> field,
>>
>> For PowerPC it is mostly the G3 PowerMacs I believe.
>
> I have one of those.  What exactly do you need from it?  I can 
> probably do
> some testing with it if needs be.

I'll cook up a patch when Stephen's patch series hits
a Git tree.  Testing would basically be trying to run
a kernel with all possible devices enabled, and seeing
if they all still work as expected.

Thanks for offering your help!  Let's see what happens
next week or so :-)


Segher
