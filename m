Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 924BDB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 14:40:51 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D858EDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 14:40:50 +1000 (EST)
Subject: powerpc-next rebased (again)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <4177854C-965A-4A26-A517-B6F0B48703BD@kernel.crashing.org>
References: <1250667232.4810.20.camel@pasglop>
	<2E8B90A3-A3FD-4EC8-9D41-1BA9E8B261AB@kernel.crashing.org>
	<5CBF10F7-8927-47AD-B4F8-1F07754207A8@kernel.crashing.org>
	<4177854C-965A-4A26-A517-B6F0B48703BD@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 20 Aug 2009 14:40:39 +1000
Message-Id: <1250743239.10937.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok so due to screwup mentioned earlier, it's rebased agian :-(

Hopefully that's the last time for very looooooong...

While at it, I removed the lmb kmemleak patch from Michael since
we decided it wasn't a good idea and added Kumar's fix for
assert_pte_locked().

I also updated the test branch with more stuff such as Fujita
IOMMU bits and pieces.

Cheers,
Ben.
