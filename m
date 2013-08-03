Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by ozlabs.org (Postfix) with ESMTP id E39342C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 23:09:22 +1000 (EST)
Date: Sat, 3 Aug 2013 15:44:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org
Subject: 3.11-rc3+git: __divdi3 undefined on powerpc (from radeon)
Message-ID: <alpine.SOC.1.00.1308031534390.1352@math.ut.ee>
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

While trying to compile v3.11-rc3-288-gabe0308 on powerpc 32-bit, 
it failed with the following linking error:

ERROR: "__divdi3" [drivers/gpu/drm/radeon/radeon.ko] undefined!

Some new 64-bit division in radeon that is not implemented on 32-bit 
powerpc?

This is new - 3.11-rc3 worked fine.

-- 
Meelis Roos (mroos@linux.ee)
