Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vkc8s75TzzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 05:15:40 +1100 (AEDT)
Date: Thu, 16 Mar 2017 11:15:27 -0700 (PDT)
Message-Id: <20170316.111527.1404979274995491797.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fs_enet: Remove useless includes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170316091804.DCA4168481@localhost.localdomain>
References: <20170316091804.DCA4168481@localhost.localdomain>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 16 Mar 2017 10:18:04 +0100 (CET)

> CONFIG_8xx is being deprecated. Since the includes dependent on
> CONFIG_8xx are useless, just drop them.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied.
