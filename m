Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 97D82100AF3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 11:05:36 +1000 (EST)
Date: Wed, 16 Jun 2010 18:05:47 -0700 (PDT)
Message-Id: <20100616.180547.200372207.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [PATCH 2/2] ehea: Fix kernel deadlock in DLPAR-mem processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <201006151735.43144.ossthema@de.ibm.com>
References: <201006151735.43144.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tklein@linux.ibm.com, adetsch@br.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Date: Tue, 15 Jun 2010 17:35:42 +0200

> Port reset operations and memory add/remove operations need to 
> be serialized to avoid a kernel deadlock. The deadlock is caused
> by calling the napi_disable() function twice.
> Therefore we have to employ the dlpar_mem_lock in the ehea_reset_port
> function as well
> 
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

Applied.
