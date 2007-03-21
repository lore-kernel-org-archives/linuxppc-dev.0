Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82580DDF6B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:02:35 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF2RvU008480
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:02:27 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF2OGq008476
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:02:24 -0600 (CST)
Date: Wed, 21 Mar 2007 09:02:24 -0600 (CST)
Subject: [PATCH 0/8] boot: cleanup and prep for more platforms
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-2-00.miltonm@bga.com>
In-Reply-To: <boot-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After comments from David, I am resending.  Per his request, I have
moved 4-7 to 0-3, and moved the common rule invocation last.  I
also added the missing sign offs.

I substantially reworked the zImage-rule one, including it be just
a default rule that any platform target can override.  Hopefully
this will make it mergable now, even as we defer how to select
the dtb and dts.  I also inserted a patch to fix the clean target
in the boot directory.

milton

boot-add-fatal
boot-crt0-missing-reloc
boot-crt0-export
boot-export-flush-cache
boot-add-wrapper-to-wrapperbits
boot-add-FORCE
boot-fix-clean
boot-zImage-rule
