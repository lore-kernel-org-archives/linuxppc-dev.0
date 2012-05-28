Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1596AB6FA3
 for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2012 13:56:48 +1000 (EST)
Date: Sun, 27 May 2012 23:55:41 -0400 (EDT)
Message-Id: <20120527.235541.34781978552783891.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 1/2] lib: Fix generic strnlen_user for 32-bit
 big-endian machines
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
References: <20120528025956.GA6822@bloggs.ozlabs.ibm.com>
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
Date: Mon, 28 May 2012 12:59:56 +1000

> The aligned_byte_mask() definition is wrong for 32-bit big-endian
> machines: the "7-(n)" part of the definition assumes a long is 8
> bytes.  This fixes it by using BITS_PER_LONG - 8 instead of 8*7.
> Tested on 32-bit and 64-bit PowerPC.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: David S. Miller <davem@davemloft.net>
