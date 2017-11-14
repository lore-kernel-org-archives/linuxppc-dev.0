Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybnZK39NCzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 23:56:24 +1100 (AEDT)
Date: Tue, 14 Nov 2017 21:56:16 +0900 (KST)
Message-Id: <20171114.215616.54799441824053779.davem@davemloft.net>
To: desnesn@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tlfalcon@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com
Subject: Re: [PATCH] [net-next,v4] ibmvnic: Feature implementation of Vital
 Product Data (VPD) for the ibmvnic driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171113175919.22541-1-desnesn@linux.vnet.ibm.com>
References: <20171113175919.22541-1-desnesn@linux.vnet.ibm.com>
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

From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 15:59:19 -0200

> This patch implements and enables VDP support for the ibmvnic driver.
> Moreover, it includes the implementation of suitable structs, signal
>  transmission/handling and functions which allows the retrival of firmware
>  information from the ibmvnic card through the ethtool command.
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied.
