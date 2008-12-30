Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F24F7DDFBD
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:27:16 +1100 (EST)
Message-Id: <8EAB94FA-153D-4AC0-8343-C9AA89A1EE1C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Update 8641hpcn dts file to match latest u-boot
Date: Tue, 30 Dec 2008 11:27:13 -0600
References: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 19, 2008, at 4:05 PM, Becky Bruce wrote:

> The newest revision of uboot reworks the memory map for this
> board to look more like the 85xx boards.  Also, some regions
> which were far larger than the actual hardware have been scaled
> back to match the board, and the imaginary second flash bank has
> been removed. Rapidio and PCI are mutually exclusive in the hardware,
> and they now are occupying the same space in the address map.
> The Rapidio node is commented out of the .dts since PCI is the
> common use case.
>
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mpc8641_hpcn.dts |   56 +++++++++++++++++ 
> +-------------
> 1 files changed, 32 insertions(+), 24 deletions(-)

applied to next.

I moved the comment up to the alias so its early in the file.

- k
