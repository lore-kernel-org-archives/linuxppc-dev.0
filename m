Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 4BBA82C00A1
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 15:53:51 +1000 (EST)
Received: from trent.utfs.org (localhost [127.0.0.1])
 by trent.utfs.org (Postfix) with ESMTP id 8E4CC3DF2D
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 07:46:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by trent.utfs.org (Postfix) with ESMTP id 740383DAC3
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 07:46:39 +0200 (CEST)
Date: Mon, 30 Jul 2012 22:46:39 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: 3.5+: yaboot, Invalid memory access
Message-ID: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

when trying to upgrade from 3.5 (final) to today's git checkout from 
Linus' tree, yaboot cannot boot and the following is printed:

  [...]
  returning from prom_init
  Invalid memory access at %SRR0: 00c62fd4  %SRR1: 00003030

The whole message: http://nerdbynature.de/bits/3.5.0/yaboot/

The Yaboot version is 1.3.16 (from Debian/testing), I haven't tried 1.3.17 
yet, its changelog does not say anything about "newer kernel support" so 
I'm not sure if this would help here.

Any other ideas?

Thanks,
Christian.
-- 
BOFH excuse #389:

/dev/clue was linked to /dev/null
