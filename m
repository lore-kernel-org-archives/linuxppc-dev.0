Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6446DDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 04:51:12 +1000 (EST)
Message-ID: <48249D12.5060307@freescale.com>
Date: Fri, 09 May 2008 13:50:58 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] 86xx: mpc8610_hpcd: use ULI526X driver
	for	on-board ethernet
References: <20080429155333.GC28166@polina.dev.rtsoft.ru>
In-Reply-To: <20080429155333.GC28166@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> As of current mainline tree, TULIP driver is unusable on MPC8610HPCD
> boards. There is a patch[1] floating around (and also included in the
> BSP), which tries to heal the situation, though the ethernet is still
> unusable. Practically it takes ages to mount NFS filesystem:

Acked-By: Timur Tabi <timur@freescale.com>

After applying this patch and Anton's two ULI driver patches, the ULI drivers
works great on an 8610HPCD.

-- 
Timur Tabi
Linux kernel developer at Freescale
