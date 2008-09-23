Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23DFCDE3B4
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 02:13:47 +1000 (EST)
Message-Id: <61BBBF2F-3DD0-47B0-B5FC-F6067C290B4D@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1221782981-4996-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v9 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Tue, 23 Sep 2008 11:13:32 -0500
References: <1221782981-4996-1-git-send-email-galak@kernel.crashing.org>
	<1221782981-4996-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 18, 2008, at 7:09 PM, Kumar Gala wrote:

> There are some minor issues with support 64-bit PTEs on a 32-bit  
> processor
> when dealing with SMP.
>
> * We need to order the stores in set_pte_at to make sure the flag word
>  is set second.
> * Change pte_clear to use pte_update so only the flag word is cleared
> * Added a WARN_ON to set_pte_at to ensure the pte isn't present for
>  the 64-bit pte/SMP case (to ensure our assumption of this fact).
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

This looks like what we discussed; and I've rebased my 8641 work on
top of it and am building and booting and LTP-ing like a champ. So....

Acked-by: Becky Bruce <becky.bruce!freescale.com>

Cheers,
B
