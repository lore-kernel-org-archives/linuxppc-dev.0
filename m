Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC57DDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:26:09 +1100 (EST)
Message-Id: <20071211142122.966506000@sipsolutions.net>
Date: Tue, 11 Dec 2007 15:21:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.25 0/5] PMU updates including suspend
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since none of the patches seem to have made it into any git tree so far,
here's a resend of my patch series that removes/replaces the adb suspend
notifiers and makes PMU suspend usable via /sys/power/state.

I have submitted a patch to allow turning off the freezer to Rafael
separately who had only minor comments on the second version which I
fixed in the third version I just sent out.

Please consider these patches for 2.6.25.

johannes
