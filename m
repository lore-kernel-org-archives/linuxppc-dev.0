Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFB85DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 01:47:12 +1100 (EST)
Message-Id: <751DF852-228C-49CF-942F-93ABCDE95AE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ed Swarthout <Ed.Swarthout@freescale.com>
In-Reply-To: <1224222092-9301-1-git-send-email-Ed.Swarthout@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix mpc8536ds dma interrupt numbers
Date: Mon, 20 Oct 2008 09:46:28 -0500
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
>
> Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8536ds.dts |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)

applied, dropped the pci changes.

- k
