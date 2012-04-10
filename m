Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0B08B7069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 04:43:45 +1000 (EST)
Date: Tue, 10 Apr 2012 14:41:36 -0400 (EDT)
Message-Id: <20120410.144136.1777978593334560368.davem@davemloft.net>
To: key@linux.vnet.ibm.com
Subject: Re: [PATCH v2 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334070657.16827.29.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
 <1334070657.16827.29.camel@key-ThinkPad-W510>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kent Yoder <key@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2012 10:10:57 -0500

> These routines add the base device driver code supporting the Power7+
> in-Nest encryption accelerator (nx) device.
> 
> Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>

This patch should be earlier in the series, so it can
appear before the drivers which use the helper routines
in here.
