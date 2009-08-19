Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EDC0CB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 17:33:58 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52F26DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 17:33:58 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7J7XrLi010154
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 02:33:54 -0500
Subject: powerpc-next rebased
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 17:33:52 +1000
Message-Id: <1250667232.4810.20.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allright it's done, let's hope I didn't screw up :-)

So I rebased the whole thing on top of latest upstream, fixing along the
way the bug that Becky found in tlb.h and fixing up a commit name from
Kumar that was referencing the wrong board. I also applied to -next the
remaining things that were in -test, except for my _PAGE_EXEC rework.

I've added a Kumar's fix for assert_pte_locked() and merged Paulus per
counter callchain support while at it

I also pushed out an updated -test with the new variant of the
_PAGE_EXEC rework and a couple more things hanging off patchwork, I'll
probably add a bit more such as the pending iommu bits tomorrow.

Cheers,
Ben.
