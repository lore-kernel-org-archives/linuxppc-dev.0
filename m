Return-Path: <det.nicolas@free.fr>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id 0752267A73
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2005 03:55:09 +1100 (EST)
From: Nicolas DET <det.nicolas@free.fr>
To: Sven Luther <sl@bplan-gmbh.de>, dholm@gentoo.org
Date: 04 Mar 2005 17:54:32 +0100
Message-Id: <20050304165506.3BCA51C00268@mwinf0808.wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: 750CXe rev 3.1 patch & Calibrated TAU patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

750CXe patch: http://powernico.free.fr/patch_750CXe_2.6.11
The 750CXe rev 3.1 is recognized has a 745/755. This small patch simply add
entry for this CPU. The properties are copy/paste from the "normal" 750CXe.
This problem has been pointed by the bPlan staff.
This CPU (750CXe rev 3.1, prv 0008 3311) is used on Pegasos I and Pegasos
II.

Calibrated TAU: http://powernico.free.fr/patch_calibrated_TAU
Small patch which allow to set an "offset" to the temperature given by the
CPU. This way, cat /proc/cpuinfo will give a more useful information.
In the future, a dynamic offset though /proc or /sys would be better.

Regards,
-- 
Nicolas DET
MorphOS & Linux developer
