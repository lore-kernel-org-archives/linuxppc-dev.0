Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D8E7ADDF26
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:39:44 +1000 (EST)
Message-Id: <20080610142702.354823071@arndb.de>
Date: Tue, 10 Jun 2008 16:27:02 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 0/5] powerpc: cleanup of unused Kconfig symbols
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A number of drivers have dependencies on symbols that we had in
arch/ppc but nowhere else. On the basis that this is all dead
code now, this series removes them completely.

I did not try to find symbols that are always enabled in
arch/powerpc but not in arch/ppc, like CONFIG_PPC_MERGE,
but Kumar mentioned that he was going to look into those.

You can pull these into powerpc/next from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git ppc-removal-more

	Arnd <><

-- 

reposted to correct address...
