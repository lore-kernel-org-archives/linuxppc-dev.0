Return-Path: <kumar.gala@freescale.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id 54B962BDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2004 10:02:24 +1100 (EST)
In-Reply-To: <418FF992.8040604@mvista.com>
References: <418FF992.8040604@mvista.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32E32A44-31DA-11D9-9BE7-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 8 Nov 2004 17:02:01 -0600
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: akpm <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32] Add setup_indirect_pci_nomap() routine
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark,

Out of interest, why would we not want to ioremap the cfg addr/data 
registers?

- kumar

On Nov 8, 2004, at 4:56 PM, Mark A. Greer wrote:

> This patch adds a routine that sets up indirect pci config space access
> but doesn't ioremap the config space addr/data registers.
>
> Signed-off-by: Mark Greer <mgreer@mvista.com>
> <indirect_pci.patch>
