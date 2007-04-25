Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A305EDDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 14:27:29 +1000 (EST)
Date: Tue, 24 Apr 2007 21:27:36 -0700 (PDT)
Message-Id: <20070424.212736.115930755.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
References: <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<1177459397.14873.160.camel@localhost.localdomain>
	<baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 25 Apr 2007 02:50:13 +0200

> The SPARC tree carries the same broken code -- is
> this just a case of code copying, or are there
> actual SPARC machines with such broken trees?

There have been many cases of missed or even erroneous
properties on sparc tree, but I am not too sure about
the cell counting cases.

Let's do this, once the consolidation is done keeping
behavior as-is, give me a patch to review that changing
the cell counting bits and I'll verify it against
all the machines I have here plus some OFW tree dumps.
