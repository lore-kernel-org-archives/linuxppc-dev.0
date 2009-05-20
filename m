Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C5B59DE0D8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 00:48:20 +1000 (EST)
Message-ID: <4A141810.4020104@freescale.com>
Date: Wed, 20 May 2009 09:47:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash size
References: <1242155174-2513-1-git-send-email-wd@denx.de>
	<2a27d3730905130328m27743852w2d68a62ebc32ce31@mail.gmail.com>
	<20090513194249.BA7D9832E416@gemini.denx.de>
	<156C2E1E-8E67-4358-B72E-4BB67D79C2AF@kernel.crashing.org>
In-Reply-To: <156C2E1E-8E67-4358-B72E-4BB67D79C2AF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Li Yang <leoli@freescale.com>,
	Wolfgang Denk <wd@denx.de>, LKML List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Scott, any feedback if our boards have 8M or 32M flash modules?

According to the manual, it comes with 8 but can be expanded to 32.  I 
don't think we swapped out the flash SIMM that came with the board.

As I wrote earlier in the thread, I don't see any way a current u-boot 
would enable more than 8MiB of flash on this board anyway.  I'd go ahead 
and apply the patch.

-Scott
