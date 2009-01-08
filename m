Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 87964DE76E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 05:58:48 +1100 (EST)
Date: Thu, 08 Jan 2009 10:58:48 -0800 (PST)
Message-Id: <20090108.105848.174722136.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] gianfar: Fixup use of BUS_ID_SIZE
From: David Miller <davem@davemloft.net>
In-Reply-To: <1231343521-22171-1-git-send-email-galak@kernel.crashing.org>
References: <1231343521-22171-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, kay.sievers@vrfy.org, afleming@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed,  7 Jan 2009 09:52:01 -0600

> Commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 went back to using
> BUS_ID_SIZE instead of sizeof() as per the larger patch series
> that will remove "char bus_id[20]" from struct device.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied, thanks Kumar.
