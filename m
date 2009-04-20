Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEC70DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:58:17 +1000 (EST)
Message-Id: <1A543523-16F5-4295-B60D-4FD4E5B9FE0E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 3/5] powerpc: make dma_window_* in pci_controller struct
	avail on 32b
Date: Mon, 20 Apr 2009 11:58:11 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:

> Also, convert them to resource_size_t (which is unsigned long
> on 64-bit, so it's not a change there).
>
> We will be using these on fsl 32b to indicate the start and size
> address of memory that the pci controller can actually reach - this
> is needed to determine if an address requires bounce buffering.  For
> now, initialize them to a standard value; in the near future, the
> value will be calculated based on how the inbound windows are
> programmed.
>
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/pci-bridge.h |    6 ++++--
> arch/powerpc/sysdev/fsl_pci.c         |    4 ++++
> 2 files changed, 8 insertions(+), 2 deletions(-)

Ben, your ack on this patch would be appreciated as I've got some  
other FSL PCI patches that I want to fold this into my tree for.

- k
