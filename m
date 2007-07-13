Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 21E10DE35E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:45:36 +1000 (EST)
Message-Id: <20070713184452.466490031@arndb.de>
Date: Fri, 13 Jul 2007 20:44:52 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 0/5] Kconfig cleanup
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger <jdl@freescale.com> wrote:
X-Provags-ID: V01U2FsdGVkX18a539ZiXmAXeY+eK9MdUjOkwfvlvR4PUC8vLN
 hv7FFOkt1BgOy18T2Tf8fQgBcT+SMke7QjZMwzOtjX3HPEZzfI
 I86h59GhTM7GU39vE50ww==

> Hmmm... Shouldn't this sort of change come
> with an update to the 8641 defconfig too?

Yes, good point. This updates the various defconfig files
that are impacted by the changes, and applied cleanly
against the latest powerpc.git again.

	Arnd <><
