Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BA45DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 17:32:11 +1100 (EST)
Message-Id: <FF67DC7A-7BFF-4421-9C12-31BA13D12081@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ed Swarthout <Ed.Swarthout@freescale.com>
In-Reply-To: <1224222092-9301-1-git-send-email-Ed.Swarthout@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix mpc8536ds dma interrupt numbers
Date: Fri, 17 Oct 2008 01:32:02 -0500
References: <1224222092-9301-1-git-send-email-Ed.Swarthout@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 17, 2008, at 12:41 AM, Ed Swarthout wrote:

> Swap pci1 and pci2 labels -
> Per user manual, pcie1 is at a000 and pcie2 is at 9000.

the pcie labels are correct.. they DO NOT reflect the UMs.  (as that  
number is just silly).

- k
