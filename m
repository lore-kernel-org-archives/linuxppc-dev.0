Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE014.bigfish.com (ch1ehsobe006.messaging.microsoft.com
	[216.32.181.186]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E81831007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 02:05:45 +1000 (EST)
Message-ID: <4E15D953.9030609@freescale.com>
Date: Thu, 7 Jul 2011 11:05:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH] powerpc/p1022ds: Remove fixed-link property from ethernet
	nodes.
References: <1310024270-2675-1-git-send-email-felix@embedded-sol.com>
In-Reply-To: <1310024270-2675-1-git-send-email-felix@embedded-sol.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> On P1022DS both ethernet controllers are connected to RGMII PHYs
> accessible via MDIO bus. Remove fixed-link property from ethernet
> nodes as they only required when fixed link PHYs without MDIO bus
> are used.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>

Acked-by: Timur Tabi <timur@freescale.com>

Ethernet works before and after applying this patch, so all I can say is that it
doesn't break anything.

-- 
Timur Tabi
Linux kernel developer at Freescale
