Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFjBZ4R7lzF0cP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 04:36:52 +1100 (AEDT)
Date: Mon, 08 Jan 2018 12:36:46 -0500 (EST)
Message-Id: <20180108.123646.365615764088683051.davem@davemloft.net>
To: mpe@ellerman.id.au
Cc: linux@rasmusvillemoes.dk, michael@concordia.ellerman.id.au, j@w1.fi,
 netdev@vger.kernel.org, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org, johannes.berg@intel.com
Subject: Re: [net] Revert "net: core: maybe return -EEXIST in __dev_alloc_name"
From: David Miller <davem@davemloft.net>
In-Reply-To: <874lnx2fqj.fsf@concordia.ellerman.id.au>
References: <87bmirpf29.fsf@concordia.ellerman.id.au>
 <20180102.115008.2038929402603091054.davem@davemloft.net>
 <874lnx2fqj.fsf@concordia.ellerman.id.au>
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

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 08 Jan 2018 14:26:12 +1100

> I don't see it in rc7, will it get to Linus sometime before the
> release?

I will do what I can to make sure it does, it is in my GIT tree.
