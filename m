Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcNpK748zzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 07:23:37 +1000 (AEST)
Date: Tue, 22 Aug 2017 14:23:35 -0700 (PDT)
Message-Id: <20170822.142335.399786569566458902.davem@davemloft.net>
To: bhumirks@gmail.com
Cc: julia.lawall@lip6.fr, pantelis.antoniou@gmail.com,
 vbordug@ru.mvista.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: freescale: fs_enet: make mdiobb_ops const
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503389759-17545-1-git-send-email-bhumirks@gmail.com>
References: <1503389759-17545-1-git-send-email-bhumirks@gmail.com>
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

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Tue, 22 Aug 2017 13:45:59 +0530

> Make this const as it is only stored in a const field of a
> mdiobb_ctrl structure.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied.
