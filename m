Message-Id: <200004231142.HAA65437@p2.parker.boston.ma.us>
To: linuxppc-embedded@lists.linuxppc.org
Subject: CONFIG_ALL_PPC
Date: Sun, 23 Apr 2000 07:42:25 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I tried to build the lastest bk tree (2.3.99-pre6?) last night for embedded
860 and the link failed missing "feature_init()".

the arch/ppc/kernel/Makefile conditionally builds feature.c based on
CONFIG_ALL_PPC

Is CONFIG_ALL_PPC really "all ppc" or is it really "all macintosh platforms"?

Looking at feature.c it looks like CONFIG_ALL_PPC is specific to the
platforms which will boot macos.

I can put a #ifndef CONFIG_ALL_PPC around the feature_init call but I
thought I'd ask the larger question... (and risk a tomato ;_)

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
