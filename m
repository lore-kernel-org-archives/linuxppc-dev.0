Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AB2C2B7C09
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 06:49:54 +1100 (EST)
Date: Sun, 14 Feb 2010 11:50:07 -0800 (PST)
Message-Id: <20100214.115007.94112348.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 8/9] of/sparc: Remove sparc-local declaration of
	allnodes and devtree_lock
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100213160309.4767.94443.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160309.4767.94443.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 09:03:09 -0700

> Both allnodes and devtree_lock are defined in common code.  The
> extern declaration should be in the common header too so that the
> compiler can type check.  allnodes is already in of.h, but
> devtree_lock should be declared there too.
> 
> This patch removes the SPARC declarations and uses decls in of.h instead.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
