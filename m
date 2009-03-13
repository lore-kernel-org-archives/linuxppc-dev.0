Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8B774DDFBD
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 07:51:01 +1100 (EST)
Date: Fri, 13 Mar 2009 13:50:48 -0700 (PDT)
Message-Id: <20090313.135048.202553524.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [PATCH net-next-2.6] ehea: fix circular locking problem
From: David Miller <davem@davemloft.net>
In-Reply-To: <200903121620.19075.ossthema@de.ibm.com>
References: <200903121620.19075.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, hering2@de.ibm.com, netdev@vger.kernel.org,
	themann@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Date: Thu, 12 Mar 2009 16:20:18 +0100

> This patch fixes the circular locking problem by changing the locking strategy
> concerning the logging of firmware handles.
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

Applied, thanks.
