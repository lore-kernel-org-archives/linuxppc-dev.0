Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B14967B83
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:35 +1000 (EST)
Message-Id: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/12] aoa: fix regressions over snd-powermac
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series fixes the remaining regressions over snd-powermac that I
am aware of. Most of the important patches are from BenH, thanks!

Most notably:
 * works on PowerMac7,2/7,3 now
 * adds DRC,bass and treble controls to tas3004-based machines

I've picked up Andreas' patch as the first patch in this series because the
rest of the series depends on it and it isn't in any tree yet.

Please merge for 2.6.18.

johannes
