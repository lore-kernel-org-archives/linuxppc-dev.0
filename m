Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59FDCDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 09:08:03 +1000 (EST)
Message-Id: <095F258F-72DD-4F27-A457-A57D9FAA1E76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <48445851.4090105@garzik.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] phylib: Don't allow core of phylib to build as a module
Date: Mon, 2 Jun 2008 18:07:52 -0500
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<48442239.7090906@garzik.org>
	<BF15FEBB-4876-4B16-915B-1D21BF989DA8@kernel.crashing.org>
	<83820D83-487C-4586-9867-F4226A87A276@freescale.com>
	<48445851.4090105@garzik.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 2, 2008, at 3:30 PM, Jeff Garzik wrote:

> Andy Fleming wrote:
>> I'm partial to the select-it-if-you-need-it paradigm.
>
>
> AFAICS this can all be solved by the platform Kconfig ensuring that  
> phylib=y

I don't care for this as it means making sure each platform/board port  
gets it right.  I think we'd be better off with a small stub that is  
always built into the kernel for phy_read/phy_write, etc or the  
function pointer indirection mechanism.

- k
