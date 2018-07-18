Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vt1S3dp0zF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 20:00:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Hanselmann <linux-kernel@hansmi.ch>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH] Mark ams driver as orphaned in MAINTAINERS
In-Reply-To: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
References: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
Date: Wed, 18 Jul 2018 20:00:10 +1000
Message-ID: <877elsq2xh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Hanselmann <linux-kernel@hansmi.ch> writes:

> I no longer have any hardware with the Apple motion sensor and thus
> relinquish maintainership of the driver.

Thanks. I think I'll just remove the whole entry, meaning it will be
caught under the "LINUX FOR POWER MACINTOSH" entry.

Unless you object. Full patch below.

cheers

commit 19fe15338d6935c1a61a24b83dd315970b1ba162
Author:     Michael Hanselmann <linux-kernel@hansmi.ch>
AuthorDate: Mon Jan 29 22:40:09 2018 +0000
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Wed Jul 18 19:57:42 2018 +1000

    MAINTAINERS: Remove the entry for the orphaned ams driver
    
    I no longer have any hardware with the Apple motion sensor and thus
    relinquish maintainership of the driver.
    
    Remove the maintainers entry entirely, meaning the code will now fall
    under "LINUX FOR POWER MACINTOSH".
    
    Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
    [mpe: Drop the entry entirely, munge change log]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..50e398a463f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -791,11 +791,6 @@ S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
-AMS (Apple Motion Sensor) DRIVER
-M:	Michael Hanselmann <linux-kernel@hansmi.ch>
-S:	Supported
-F:	drivers/macintosh/ams/
-
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
