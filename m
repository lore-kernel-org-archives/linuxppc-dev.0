Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 350F4B708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 08:29:04 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BD5B9DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 08:29:03 +1000 (EST)
Date: Sat, 27 Jun 2009 02:29:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 0/4 for 2.6.31] NET: Revive fixed link support
Message-ID: <20090626222900.GA14594@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

The fixed link support is broken since The Big OF MDIO Rework,
the rework simply removed most of the code that was needed for
fixed links.

Too bad I didn't notice this earlier, I saw a bunch of patches
on the ml, but unfortunately I didn't look very close presuming
that Grant knew what he was doing. :-) And obviously I didn't
test linux-next on anything that requires a fixed link.

Anyway, here are four patches. The first one adds the fixed link
support to a framework, otherwise we'd duplicate the code across
the drivers (as we did previously), and I tried to keep drivers'
changes minimal.

Patches 2 and 3 are for the drivers that I tested in run-time,
with normal PHYs, and fixed links.

Patch #4 was build-tested, but I believe it should work in
run-time too.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
