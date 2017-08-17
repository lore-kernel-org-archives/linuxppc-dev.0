Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYCbM17M6zDrL2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:18:06 +1000 (AEST)
Date: Thu, 17 Aug 2017 10:18:04 -0700 (PDT)
Message-Id: <20170817.101804.2016942034542452971.davem@davemloft.net>
To: arvind.yadav.cs@gmail.com
Cc: tlfalcon@linux.vnet.ibm.com, benh@kernel.crashing.org,
 jallen@linux.vnet.ibm.com, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: ibm: ibmveth: constify vio_device_id
From: David Miller <davem@davemloft.net>
In-Reply-To: <b8393cdf646fae5ccbb64aab482c133fd54a7339.1502975929.git.arvind.yadav.cs@gmail.com>
References: <b8393cdf646fae5ccbb64aab482c133fd54a7339.1502975929.git.arvind.yadav.cs@gmail.com>
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

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 17 Aug 2017 18:52:53 +0530

> vio_device_id are not supposed to change at runtime. All functions
> working with vio_device_id provided by <asm/vio.h> work with
> const vio_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
