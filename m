Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC98DDDFD5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:00:51 +1100 (EST)
Message-Id: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/12] powerpc/powermac power management patches
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's my current patch series that grew from implementing suspend to disk
for my powermac to a general suspend code cleanup.

One of the nice patches in this series allows you to finally suspend
via
  echo mem > /sys/power/state
on powerbooks!

I've tested this whole patchset on my powerbook as well as my powermac
(which can with it suspend for the first time) and it all works well.

I expect that you will be finding problems with this, but I hope to
get this included some time in the not-too-distant future.

This patchset depends on the patches
 * snd-aoa: fix onyx resume
 * windfarm: don't die on suspend thread signal
to work, but will probably not apply unless you also have
 * powermac: clean up PIC initialisation code

johannes
