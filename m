Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD25BDDDDF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 00:39:30 +1100 (EST)
Message-Id: <7110514B-F0F1-4650-A3CC-E09178CBC262@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081118105451.7835.78476.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Use generic PHY driver for Marvell 88E1111 PHY
	on GE Fanuc SBC610
Date: Tue, 18 Nov 2008 07:39:21 -0600
References: <20081118102023.7047.94495.stgit@ubuntu8041.localdomain>
	<20081118105451.7835.78476.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 18, 2008, at 4:55 AM, Martyn Welch wrote:

> The Marvell PHY driver is currently being used for the 88E1111 on the
> SBC610. This driver is causing the link to run in 10/Half mode, the  
> generic
> PHY driver is correctly configuring the PHY as 1000/Full.
>
> Edit default config to use generic PHY driver.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> Agh! My mistake - forgot to add "Signed-off", sorry.
>
> arch/powerpc/configs/86xx/gef_sbc610_defconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

hmm.. why not fix the issue with the 88e1111 driver.

- k
