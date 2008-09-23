Return-Path: <osstklei@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 754F9DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 20:33:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8NAXZNi428438
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 10:33:35 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8NAXZZS4010224
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 12:33:35 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8NAXVNL001156
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 12:33:32 +0200
Message-ID: <48D8C5E0.3060400@de.ibm.com>
Date: Tue, 23 Sep 2008 12:33:04 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH] [2.6.27] ehea: Fix memory hotplug support
References: <200809171619.46741.hannes.hering@linux.vnet.ibm.com>
In-Reply-To: <200809171619.46741.hannes.hering@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> This patch implements the memory notifier to update the busmap instantly
> instead of rebuilding the whole map. This is necessary because
> walk_memory_resource provides different information than required during memory
> hotplug.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>

Jeff, please apply.

Acked-by: Thomas Klein <tklein@de.ibm.com>
