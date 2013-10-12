Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 8409C2C0356
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Oct 2013 08:11:15 +1100 (EST)
Date: Sat, 12 Oct 2013 17:11:10 -0400 (EDT)
Message-Id: <20131012.171110.246440214474931440.davem@davemloft.net>
To: aida.mynzhasova@skitlab.ru
Subject: Re: "powerpc/83xx: gianfar_ptp: select 1588 clock source through
 dts file" was added twice
From: David Miller <davem@davemloft.net>
In-Reply-To: <525962B2.8010100@skitlab.ru>
References: <525962B2.8010100@skitlab.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Date: Sat, 12 Oct 2013 18:54:42 +0400

> Hi,
> 
> recently I looked through commits in kernel/git/torvalds/linux.git and
> I noticed that my patch (old and new version) was added twice (by
> David S. Miller):
> 
> e58f6f4fb4eada7867014bfaec898f03afbce5c2
> 894116bd0e9b7749a0c4b6c62dec13c2a0ccef68
> 
> I think this is not good, and only
> e58f6f4fb4eada7867014bfaec898f03afbce5c2 should be added.

Read the code history properly.

First 894116bd0e9b7749a0c4b6c62dec13c2a0ccef68 got applied, as you say
accidently.  Then I reverted it, see commit
3f3f0960aff951c5df6e42ce292d1593a2520646.

Then I applied the correct version which is commit
e58f6f4fb4eada7867014bfaec898f03afbce5c2.

I didn't respond at all the first time you pointed this out hoping
you would figure it out on your own.
