Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCD46B7B92
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 15:31:03 +1100 (EST)
Subject: Re: [2/6] Cleanup management of kmem_caches for pagetables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20091027034602.GB20694@yookeroo.seuss>
References: <20091016052212.E565EB7BBB@ozlabs.org>
	<1256610499.2076.69.camel@pasglop>
	<20091027034602.GB20694@yookeroo.seuss>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 15:30:54 +1100
Message-ID: <1256617854.11607.72.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-27 at 14:46 +1100, David Gibson wrote:
> 
> The trick is that allocating the PGD and PMD caches is supposed to
> also create the PUD cache, because the PUD index size is always the
> same as either the PGD or PUD cache.  If that's not true, we've broken
> the assumptions the code is based on, hence BUG(). 

Ok, so maybe a little comment with the above explanation concerning
the PUD index size being the same as the PGD or PMD one would be
useful :-)

Cheers,
Ben.
