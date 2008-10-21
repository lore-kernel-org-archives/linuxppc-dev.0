Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8EFCDDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:39:46 +1100 (EST)
Message-Id: <63EC2F8B-20D2-44A9-90AF-1D518E0D3645@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for
	MPC8349E-mITX boards
Date: Mon, 20 Oct 2008 23:39:36 -0500
References: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 17, 2008, at 1:56 PM, Anton Vorontsov wrote:

> The RTC is sitting on the I2C2 bus at address 0x68. RTC interrupt  
> signal
> is connected to the IPIC's EXT2 interrupt line, the line is shared  
> with
> Vitesse 8201 Ethernet PHY.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8349emitx.dts   |    8 ++++++++
> arch/powerpc/boot/dts/mpc8349emitxgp.dts |    8 ++++++++
> 2 files changed, 16 insertions(+), 0 deletions(-)

applied

- k
