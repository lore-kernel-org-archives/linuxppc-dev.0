Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83B6BDE1F7
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:10:51 +1100 (EST)
Message-Id: <B094061B-8B4B-4E1A-BBC7-65A4E225E2B9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
In-Reply-To: <20080306151451.GA25251@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Date: Fri, 7 Mar 2008 09:10:46 -0600
References: <20080306151451.GA25251@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 9:14 AM, Alexandr Smirnov wrote:

> Add device tree file for Emerson KSI8560 board.
>
> Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>
>
> b/arch/powerpc/boot/dts/ksi8560.dts |  264 ++++++++++++++++++++++++++ 
> ++++++++++
> 1 file changed, 264 insertions(+)

Fixed up i2c to add #address-cells, #size-cells and cell-idnex

applied to powerpc-next.

- k
