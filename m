Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 06FB7DDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 04:03:54 +1000 (EST)
Date: Sun, 27 Apr 2008 20:03:46 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.25: pmac_newworld undefined
Message-ID: <alpine.DEB.1.10.0804271951190.11017@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

the build failure reported[0] by Kamalesh back in 01/2008 is still 
present in today's 2.6.25-git with CONFIG_NVRAM=m (instead of =y):

   Building modules, stage 2.
   MODPOST 72 modules
ERROR: "pmac_newworld" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
ERROR: "__alloc_bootmem" [arch/powerpc/platforms/powermac/nvram.ko] undefined!
make[1]: *** [__modpost] Error 1

Full .config and make.log: http://nerdbynature.de/bits/2.6.25/nvram/

I could not find an #ifdef or sth. around pmac_newworld....

Thanks,
Christian.

[0] http://lkml.org/lkml/2008/1/17/55
-- 
BOFH excuse #187:

Reformatting Page. Wait...
