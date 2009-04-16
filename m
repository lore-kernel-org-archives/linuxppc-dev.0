Return-Path: <geoff@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B384DDE12F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:27:09 +1000 (EST)
Message-Id: <20090416190536.540992667@am.sony.com>>
Date: Thu, 16 Apr 2009 12:05:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 0/4] PS3 2.6.30 patches
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

This is a small set of patches for 2.6.30.

(1) and (2) are simple build fixes.

(3) is a patch by Milton submitted back in October that seems to
have beed missed.  Could you consider it for 2.6.30?

(4) is an update to the MAINTAINERS file.  Can you take it?

 [patch 1/4] powerpc/ps3: Fix no SMP build error
 [patch 2/4] powerpc/ps3: Fix no flash build warning
 [patch 3/4] powerpc ps3: use smp_request_message_ipi
 [patch 4/4] maintainers: Fix PS3 patterns

-Geoff


-- 
