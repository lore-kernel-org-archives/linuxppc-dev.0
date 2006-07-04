Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id AF55167B64
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 10:28:08 +1000 (EST)
Date: Tue, 4 Jul 2006 02:28:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: -git: strange dependency for EMBEDDED6xx
Message-ID: <20060704002806.GE26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit c5d56332fd6c2f0c7cf9d1f65416076f2711ea28 contained the following:

 config EMBEDDED6xx
        bool "Embedded 6xx/7xx/7xxx-based board"
-       depends on PPC32 && BROKEN
+       depends on PPC32 && (BROKEN||BROKEN_ON_SMP)

This looks very strange.

This dependency is equivalent to
	depends on PPC32 && SMP=n

Was this the intention?
Or what else was the intention?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
