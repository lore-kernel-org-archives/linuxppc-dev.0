Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 42726DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 07:57:54 +1100 (EST)
Date: Thu, 02 Apr 2009 13:57:42 -0700 (PDT)
Message-Id: <20090402.135742.99633675.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] fsl_pq_mdio: Fix compile failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <1238679923-4370-1-git-send-email-galak@kernel.crashing.org>
References: <1238679923-4370-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu,  2 Apr 2009 08:45:23 -0500

> From: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Add EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name) for module builds
> 
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied, thanks.
