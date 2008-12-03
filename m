Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 416CEDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:54:23 +1100 (EST)
Message-ID: <49371ACA.9040800@am.sony.com>
Date: Wed, 3 Dec 2008 15:48:26 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/3] PS3 patches for 2.6.29
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here is a small set of patches for 2.6.29.  Please consider
them for your next branch.

 [patch 1/3] powerpc: Fix typo in pgtable-ppc64.h
 [patch 2/3] powerpc/ps3: Quiet dmesg output
 [patch 3/3] powerpc/ps3: Add sub-match id modalias support

-Geoff


-- 
