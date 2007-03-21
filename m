Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AEAEDDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 23:12:48 +1100 (EST)
Message-Id: <20070321104037.696668000@sipsolutions.net>
Date: Wed, 21 Mar 2007 11:40:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/6] suspend on G5
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This is a repost of my suspend for G5 patches. It's RFC instead of PATCH
because it relies on some patches that Rafael Wysocki did to remove the
pageflags that are used for suspend, so it can't be applied as-is without
having those patches too. They can be found with the patch titles
 * swsusp: Use inline functions for changing page flags
 * swsusp: Do not use page flags
 * mm: Remove unused page flags

In addition to that patch, you'll need my patch
 * swsusp: introduce register_nosave_region_late
which I posted to linux-pm in one of the
"swsusp: Do not use page flags (was: Re: Remove page flags for software suspend)"
threads.

All these patches should also be somewhere on
http://johannes.sipsolutions.net/patches/, the first three named
rafael{1,2,3}.patch.

johannes
