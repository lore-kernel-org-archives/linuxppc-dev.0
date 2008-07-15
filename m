Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3AC3DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 16:02:14 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6F62993001637
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 01:02:10 -0500
Subject: powerpc.git merge status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 16:02:09 +1000
Message-Id: <1216101729.7740.84.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've pulled from Kumar, Josh and Grant, along with applying some
patches hand picked from patchworks and build fixes. I've merged in
Linus as of today (minus David Woodhouse firmware patches that have a
build breakage) in order to fix a (fairly trivial) merge conflict.

I've now pushed that to my powerpc.git "master" branch for overnight
build-testing with kisskb at which point

If all goes well, I'll put all of that in "merge" and "next" and ask
Linus to pull it tomorrow.

Now, regarding the remaining bits, still on my todo for the next batch,
probably later this week, in this merge window:

	- The CMO stuff, I need to have a closer look but it should
          probably go in
	- Milton's serie. Mostly fixes, haven't had time to look too
          closely yet.
	- Kumar PTE bits... that's a bit "hot" for this merge window
          but I suppose it can still make it.
	- Some Cell stuff for which I'm waiting a new serie from Arnd

If you believe I've missed something, now is time to be vocal about
it :-)

Cheers,
Ben.
