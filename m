Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AED4BB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 14:15:00 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B64BDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 14:14:59 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n6S4Erl8010568
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 23:14:55 -0500
Subject: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 14:14:53 +1000
Message-Id: <1248754493.30993.47.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So I opened powerpc-next, and pushed the pile that was in "test" (with
an additional bug fix to one of my patches that was causing the crash
at boot that mpe reported with hugetlbfs enabled).

The pre-req patch for adding an argument to __pte_free_tlb() has already
been merged upstream by Linus.

Now is time for people who want things into 2.6.32 to be noisy about it.

Cheers,
Ben.
