Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13ED467BBF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 23:06:16 +1000 (EST)
Message-Id: <20060601115844.343214000@sipsolutions.net>
Date: Thu, 01 Jun 2006 13:58:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 0/8] snd-aoa: add snd-aoa
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

The following patches would add snd-aoa to the Linux source tree. I'm
posting them here in the spirit of getting review fairly early, it works
fine for those machines it handles and even implements headphone/line-out
detection now.

One thing that still needs to be done is fix this on the mac-mini where
apparently some things are missing from the device-tree, and on the
PowerMac7,2/7,3 where the device tree has a bug that prevents the i2sbus
module from working properly.

Other than that, it replaces snd-powermac for all layout-id machines, and
handles many more already, so once those two issues are fixed I'll also add
a patch to this patchset that removes support for any machines with a
layout-id from snd-powermac to allow snd-aoa and snd-powermac to coexist
nicely.

Any comments are appreciated.

--
