Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t9QFM0W0czDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 02:08:06 +1100 (AEDT)
Date: Fri, 04 Nov 2016 11:07:59 -0400 (EDT)
Message-Id: <20161104.110759.1093635654135143910.davem@davemloft.net>
To: lsanfil@marvell.com
Cc: joe@perches.com, madalin.bucur@nxp.com, akpm@linux-foundation.org,
 corbet@lwn.net, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, oss@buserror.net, ppc@mindchasers.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se
Subject: Re: Coding Style: Reverse XMAS tree declarations ?
From: David Miller <davem@davemloft.net>
In-Reply-To: <581C6A7D.8030704@marvell.com>
References: <20161103.155816.642712588084106823.davem@davemloft.net>
 <1478242438.1924.31.camel@perches.com>
 <581C6A7D.8030704@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lino Sanfilippo <lsanfil@marvell.com>
Date: Fri, 4 Nov 2016 12:01:17 +0100

> Hi,
> 
> On 04.11.2016 07:53, Joe Perches wrote:
>>
>> CHECK:REVERSE_XMAS_TREE: Prefer ordering declarations longest to
>> shortest
>> #446: FILE: drivers/net/ethernet/ethoc.c:446:
>> +			int size = bd.stat >> 16;
>> +			struct sk_buff *skb;
>>
> 
> should not this case be valid? Optically the longer line is already
> before the shorter.
> I think that the whole point in using this reverse xmas tree ordering
> is to have
> the code optically tidied up and not to enforce ordering between
> variable name lengths.

That's correct.
