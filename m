Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD7D5DDE49
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:08:03 +1100 (EST)
Message-Id: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC 00/10] suspend to disk for powermac G5
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

Here's my latest patchset for suspend to disk on powermac. It also contains
a whole bunch of cleanups and fixes in various other places some of which
are CCed to Andrew (who will hopefully put them into -mm).

Other than that, thanks to the mpic resume/suspend code it appears to work
quite well. Thanks to Michael Buesch for testing with PREEMPT enabled which
uncovered another bug with cpu "hotplug" (where I still don't understand why
the preempt_count is messed up on resume but not when I put a CPU off- and
online via sysfs.)

To actually get proper suspend for a G5 powermac with an Onyx codec you need
to apply the patch at http://patchwork.ozlabs.org/linuxppc/patch?id=8683

Any comments are appreciated, especially on the patch that actually
implements the snapshot code ("powermac: suspend to disk on G5.")

johannes
