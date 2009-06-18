Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8B25CB724D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 11:53:40 +1000 (EST)
Date: Wed, 17 Jun 2009 18:53:38 -0700 (PDT)
Message-Id: <20090617.185338.20860763.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 0/2] Revert and reimplement Add SGMII support to UCC GETH
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090617231306.7051.56146.stgit@localhost.localdomain>
References: <20090617231306.7051.56146.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sachinp@linux.vnet.ibm.com, sfr@canb.auug.org.au, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, ntl@pobox.com,
	Haiying.Wang@freescale.com, leoli@freescale.com,
	subrata@linux.vnet.ibm.com, balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 17:15:58 -0600

> (REPOST; I messed up an email address first time around and apparently my
> posting got rejected.  If you've already received this message, then
> I apologize for the noise)
> 
> Here is a fix for the build failure discovered during the 2.6.31 merge
> window on ucc_geth.c.  I decided to revert and reapply a fixed version
> of the patch to make the new version easier to review and bisect if I
> got the fixup wrong.  I've compile tested both patches, but I do not have
> hardware to run test.
> 
> Haiying, please confirm that I haven't horribly trashed your hard work
> with my changes.

I've applied these to net-next-2.6, thanks!
