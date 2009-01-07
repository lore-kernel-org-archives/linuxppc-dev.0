Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D6BADE1D5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 14:04:58 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n0734rnW006694
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jan 2009 21:04:54 -0600
Subject: linux-powerpc "master" going to be rebased
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 14:04:53 +1100
Message-Id: <1231297493.14860.54.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a little warning...

I mistakenly did the same merge twice in "next" and "master" resulting
in those two branches now drifting for ever which they shouldn't.

I'm not going to rebase "next" as I pretty much promised, so I'm going
to rebase "master" to point to the same commit as "next".

I'll do that sometimes tomorrow.

Cheers,
Ben.
