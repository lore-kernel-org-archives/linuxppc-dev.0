Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 88849DE14A
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:25:29 +1100 (EST)
Date: Sun, 28 Jan 2007 15:25:27 -0800 (PST)
Message-Id: <20070128.152527.74749301.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1170015292.26655.6.camel@localhost.localdomain>
References: <1169971963.19887.15.camel@concordia.ozlabs.ibm.com>
	<m14pqbsg2j.fsf@ebiederm.dsl.xmission.com>
	<1170015292.26655.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: greg@kroah.com, kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, ebiederm@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 29 Jan 2007 07:14:52 +1100

> > Which should be good enough to handle everything but RTAS.
> 
> You keep ignoring the problem then... we -HAVE- to handle the RTAS case.
> In addition, it's not unlikely that other virtualized environment will
> provide a similar very high level APIs to MSIs.

I believe sparc64 has similar issues to RTAS fwiw.
