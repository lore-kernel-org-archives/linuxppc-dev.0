Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71A6BDE24D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 01:18:55 +1100 (EST)
Message-Id: <46DCF924-7407-4C6E-8873-EAF40F74FAA3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081008181605.GA15034@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: add DS1374 RTC support for the MPC837xE-MDS
	boards
Date: Fri, 10 Oct 2008 09:18:50 -0500
References: <20081008181605.GA15034@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2008, at 1:16 PM, Anton Vorontsov wrote:

> The RTC is sitting on the I2C1 bus at address 0x68. RTC interrupt  
> signal
> is connected to the IPIC's EXT3 interrupt line.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    7 +++++++
> arch/powerpc/boot/dts/mpc8378_mds.dts |    7 +++++++
> arch/powerpc/boot/dts/mpc8379_mds.dts |    7 +++++++
> 3 files changed, 21 insertions(+), 0 deletions(-)

applied.

- k
