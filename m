Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zb7gX4PqRzF0v6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 13:28:54 +1100 (AEDT)
Date: Mon, 05 Feb 2018 21:28:49 -0500 (EST)
Message-Id: <20180205.212849.1560796586530409083.davem@davemloft.net>
To: desnesn@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tyreld@linux.vnet.ibm.com, tlfalcon@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH, net] ibmvnic: fix empty firmware version and errors
 cleanup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180205163355.16064-1-desnesn@linux.vnet.ibm.com>
References: <20180205163355.16064-1-desnesn@linux.vnet.ibm.com>
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
Date: Mon,  5 Feb 2018 14:33:55 -0200

> This patch makes sure that the firmware version is never NULL. Moreover,
> it also performs some cleanup on the error messages.
> 
> Fixes: a107311d7fdf ("ibmvnic: fix firmware version when no firmware level
> has been provided by the VIOS server")
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>

Applied, thanks.
