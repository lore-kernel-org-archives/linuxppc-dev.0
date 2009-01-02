Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 070C7DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 07:42:56 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH 0/5 + 2] kexec updates
Date: Fri, 02 Jan 2009 14:42:38 -0600
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Follwing this mail are 5 patches for kexec userspace and two for the
kernel.  The first fixes an array overflow and the second updates
userspace to the merged 2.6.28 kdump support.  The remaining are
cleanups and warning fixes, including one for the common code.

The two patchs for the kernel are independent.

milton
