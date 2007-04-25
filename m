Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 20BE9DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 05:03:13 +1000 (EST)
In-Reply-To: <462F93F0.5090608@genesi-usa.com>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>	<20070403223914.35bf04e1.sfr@canb.auug.org.au>	<20070403224039.913af749.sfr@canb.auug.org.au>	<20070403224205.807cffe0.sfr@canb.auug.org.au>	<20070403224340.5533abc9.sfr@canb.auug.org.au>	<20070403224505.5d5a1495.sfr@canb.auug.org.au>	<20070403224610.b61c7377.sfr@canb.auug.org.au>	<20070403224937.f6a07e56.sfr@canb.auug.org.au>	<20070403225059.e735b5e4.sfr@canb.auug.org.au>	<20070403225222.88e92221.sfr@canb.auug.org.au>	<20070403230505.f96ea210.sfr@canb.auug.org.au>	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>	<20070412141905.6f30efd3.sfr@canb.auug.org.au>	<20070412153424.bf3957f4.sfr@canb.auug.org.au>	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>	<20070424223930.1dab0e28.sfr@canb.auug	.org.au>
	<06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>	<17966.45645.902486.793443@cargo.ozlabs.ibm.com>	<1177477630.14873.185.camel@localhost.localdomain>
	<c249005137aa3e50c25221f6849a70ea@kernel.crashing.org>
	<462F93F0.50906 08@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <033031ecd45c3b94bd3d7a73609abe3c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Consolidate of_find_property
Date: Wed, 25 Apr 2007 21:02:09 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't top-post.  Thank you.

> Can't the ata/ATA thing be fixed by simply fixing device trees where it
> happens? strncmp seems the standards-compliant route to take..

Sure it can.  But for now, strcasecmp() is the
best route to take, at least for powerpc (it
preserves the existing behaviour).  Can't change
everything at once, every single change can
potentially break some platforms.  One step at a
time.


Segher
