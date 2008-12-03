Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B923ADDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:57:56 +1100 (EST)
Message-Id: <2692D1A5-EA95-4C25-8A0A-DFE9C28C10BC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081127173645.GA28796@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Fix MCU support merge issue in
	mpc8349emitx.dts
Date: Wed, 3 Dec 2008 09:57:49 -0600
References: <20081127173645.GA28796@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 27, 2008, at 11:36 AM, Anton Vorontsov wrote:

> Just found the merge issue in 442746989d92afc125040e0f29b33602ad94da99
> ("powerpc/83xx: Add support for MCU microcontroller in .dts files"):
> the commit adds the MCU controller node into the DMA node, which is
> wrong because the MCU sits on the I2C bus. Fix this by moving the MCU
> node into the I2C controller node.
>
> The original patch[1] was OK though. ;-)
>
> [1] http://patchwork.ozlabs.org/patch/4895/
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8349emitx.dts |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)

applied to merge

- k
