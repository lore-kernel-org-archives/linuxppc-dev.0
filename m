Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 36BD4B6FC4
 for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2012 13:57:44 +1000 (EST)
Date: Sun, 27 May 2012 23:56:40 -0400 (EDT)
Message-Id: <20120527.235640.1644147106476829779.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 2/2] powerpc: Use the new generic strncpy_from_user()
 and strnlen_user()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120528030347.GB6822@bloggs.ozlabs.ibm.com>
References: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
 <20120528030347.GB6822@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Mon, 28 May 2012 13:03:47 +1000

> This is much the same as for SPARC except that we can do the find_zero()
> function more efficiently using the count-leading-zeroes instructions.
> Tested on 32-bit and 64-bit PowerPC.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Looks great.

Acked-by: David S. Miller <davem@davemloft.net>

I might hack sparc64 to use 'lzd' or 'popc' on newer chips via code
patching at some point.
