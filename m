Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [212.146.94.66])
	by ozlabs.org (Postfix) with ESMTP id 1F1D4DE4BA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 00:13:16 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] oprofile support for ppc750
Date: Tue,  6 Jan 2009 14:55:33 +0200
Message-Id: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Adds oprofile support for ppc750. ppc750 performance counters
interface is similar with G4, but it only has 4 performance counters
instead of 6.

I tested this on a PPC750GX and it seems to work fine. 

tavi
