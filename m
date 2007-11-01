Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13AB7DDE35
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 01:08:42 +1100 (EST)
Subject: Re: libfdt as its own repo and submodule of dtc?
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071031225624.GB16119@localhost.localdomain>
References: <C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org>
	<E1ImtSB-0003vC-0j@jdl.com> <4727665E.1070109@ge.com>
	<20071030234011.GE2784@localhost.localdomain>
	<F940E9CC-1F15-4EC5-94DC-A600FD702380@kernel.crashing.org>
	<20071031225624.GB16119@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1193925881.15380.8.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 01 Nov 2007 09:04:42 -0500
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Jerry Van Baren <gerald.vanbaren@ge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-31 at 17:56, David Gibson wrote:

> I'm not too keen on using a git feature that's more recent than the
> git in most distros.

I'm going to consider this argument null and void on two fronts:

You don't use git for patch generation and submission anyway.

The Linux Community happily embraced and used early
versions of git, installing it themselves if needed,
long before it was available in _any_ distro.

Thanks,
jdl
