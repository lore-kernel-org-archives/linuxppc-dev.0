Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EDA52DDF78
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 19:14:27 +1100 (EST)
Date: Thu, 02 Apr 2009 01:14:16 -0700 (PDT)
Message-Id: <20090402.011416.201364166.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH 2/2] ucc_geth: Remove unused header
From: David Miller <davem@davemloft.net>
In-Reply-To: <1238506979-8678-2-git-send-email-galak@kernel.crashing.org>
References: <1238506979-8678-1-git-send-email-galak@kernel.crashing.org>
	<1238506979-8678-2-git-send-email-galak@kernel.crashing.org>
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
Date: Tue, 31 Mar 2009 08:42:59 -0500

> Now that the driver is exclusively an of_platform driver we no longer
> use the structs and #defines in fsl_devices.h
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied.
