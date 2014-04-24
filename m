Return-Path: <joel@jms.id.au>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BBB701413FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:25:54 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id fb1so994006pad.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:25:51 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 0/5] powerpc/powernv: OPAL sysparam sysfs fixes
Date: Thu, 24 Apr 2014 16:55:32 +0930
Message-Id: <1398324337-896-1-git-send-email-joel@jms.id.au>
Cc: neelegup@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These fix the issues I saw when testing the sysparam sysfs API. As some of the
parameters are not available on the machine I was using, the error paths in the
sysfs and OPAL code are tested, and were found to have some bugs.

Joel Stanley (5):
  powerpc/powernv: Fix sysparam sysfs error handling
  powerpc/powernv: Use ssize_t for sysparam return values
  powerpc/powernv: Check sysfs size before copying
  powerpc/powernv: Fix typos in sysparam code
  powerpc/powernv: Check sysparam size before creation

 arch/powerpc/platforms/powernv/opal-sysparam.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
1.9.1
