Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 203C51A00F7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 04:28:22 +1000 (EST)
Date: Fri, 22 Aug 2014 11:28:19 -0700 (PDT)
Message-Id: <20140822.112819.1726017415445947463.davem@davemloft.net>
To: anton@samba.org
Subject: Re: [PATCH] ibmveth: Fix endian issues with rx_no_buffer statistic
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140822113652.7e4bdc78@kryten>
References: <20140822113652.7e4bdc78@kryten>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, santil@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>
Date: Fri, 22 Aug 2014 11:36:52 +1000

> Hidden away in the last 8 bytes of the buffer_list page is a solitary
> statistic. It needs to be byte swapped or else ethtool -S will
> produce numbers that terrify the user.
> 
> Since we do this in multiple places, create a helper function with a
> comment explaining what is going on.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied, thanks Anton.
