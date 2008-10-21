Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4540DDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 17:11:32 +1100 (EST)
Message-ID: <48FD728A.2090504@garzik.org>
Date: Tue, 21 Oct 2008 02:11:22 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH] ehea: Fix memory hotplug support
References: <200809171619.46741.hannes.hering@linux.vnet.ibm.com>
	<200810151318.59151.hannes.hering@linux.vnet.ibm.com>
	<48F7056F.7050602@garzik.org>
	<200810161136.42822.hannes.hering@linux.vnet.ibm.com>
In-Reply-To: <200810161136.42822.hannes.hering@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
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
> ---
> Jeff, as requested, this patch is now based on davem's net-2.6.git.

applied
