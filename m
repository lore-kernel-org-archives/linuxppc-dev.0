Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4B246DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 14:31:47 +1000 (EST)
Date: Tue, 24 Apr 2007 21:31:53 -0700 (PDT)
Message-Id: <20070424.213153.89127563.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: David Miller <davem@davemloft.net>
In-Reply-To: <17966.45645.902486.793443@cargo.ozlabs.ibm.com>
References: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>
	<17966.45645.902486.793443@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 25 Apr 2007 11:43:41 +1000

> The question is, what ppc drivers would break if we used strcmp
> instead of strcasecmp?  I have a dim memory that some Apple machines
> had "ata" and others had "ATA" for the hard disk, for instance.

To be honest, I am sure there are a lot more examples of this
on Apple machines.
