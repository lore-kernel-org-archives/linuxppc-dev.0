Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B2D56B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 16 Aug 2009 08:20:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DF9DDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2009 08:20:21 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7FMKHmr029384
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 17:20:18 -0500
Subject: Poll: Rebasing of powerpc-next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 16 Aug 2009 08:20:17 +1000
Message-Id: <1250374817.24143.71.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi !

I'd like to rebase powerpc-next ... a few bugs have been found that it
would be nice to fix in the original patch rather than introducing a
bisection breakage, and Kumar also just noticed a potentially misleading
error in a commit message from his tree.

So who is not ok with me doing that tomorrow or tuesday ?

Cheers,
Ben.
