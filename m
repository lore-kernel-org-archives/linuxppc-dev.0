Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 782482C012A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2013 10:28:51 +1000 (EST)
Message-ID: <522D163E.80106@roeck-us.net>
Date: Sun, 08 Sep 2013 17:28:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: powerpc allmodconfig build broken due to commit 15863ff3b (powerpc:
 Make chip-id information available to userspace)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

powerpc allmodconfig build on the latest upstream kernel results in:

ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!

This is due to commit 15863ff3b (powerpc: Make chip-id information available to userspace).
Not surprising, as cpu_to_chip_id() is not exported.

Reverting this commit fixes the problem. Any good idea how to fix it for real ?

Guenter
