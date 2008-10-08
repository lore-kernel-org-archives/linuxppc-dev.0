Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C3AD3DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 18:25:25 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <29d58cf74ce079976ecb583333a442d4@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: patches for 2.6.28
Date: Wed, 8 Oct 2008 02:28:13 -0500
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben, Paul

Please merge or comment on the following patches for 2.6.28.  They were=20=

originally posted for 2.6.27 as the merge window was opening and got=20
lost in the shuffles.  I verified they still applied to Ben's next tree=20=

on 10/5, with minor offsets.
=A0
powerpc: numa.c: always trim to lmb_end_of_DRAM
http://oldpatchwork.ozlabs.org/linuxppc/patch?person=3D79&id=3D19577

powerpc: pseries, cell: use cpu_thread_in_core in smp_init for=20
of_spin_map
http://oldpatchwork.ozlabs.org/linuxppc/patch?person=3D79&id=3D19578

powerpc: find and destroy possible stale kernel added properties
http://oldpatchwork.ozlabs.org/linuxppc/patch?person=3D79&id=3D19579

powerpc: add static and ifdef prom_strtoul and prom_memparse
http://oldpatchwork.ozlabs.org/linuxppc/patch?person=3D79&id=3D19580

thanks,
milton=
