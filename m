Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 91A1C1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 02:25:26 +1000 (AEST)
Date: Mon, 20 Apr 2015 12:25:19 -0400 (EDT)
Message-Id: <20150420.122519.1661605449214047938.davem@davemloft.net>
To: linux@roeck-us.net
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make
 sparc64 use scalable lib/iommu-common.c functions)
From: David Miller <davem@davemloft.net>
In-Reply-To: <55348BE1.4010305@roeck-us.net>
References: <20150419183625.GA18901@oracle.com>
 <1429498885.28239.4.camel@ellerman.id.au>
 <55348BE1.4010305@roeck-us.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
 sowmini.varadhan@oracle.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 19 Apr 2015 22:17:21 -0700

> The debug option is intended for all _other_ architectures, to
> ensure that changes made for those don't break alpha/s390
> builds. alpha/s390 have ARCH_NEEDS_WEAK_PER_CPU and don't need the
> debug option.

Ironically this would not create a build failure for the architectures
where this matters, because only powerpc has the like named percpu
symbol.

So it's not really meeting the stated objective in this case.
