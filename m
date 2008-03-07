Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDC74DE106
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:07:21 +1100 (EST)
Message-Id: <BFCB2BE0-50DE-4E38-8BC9-D9BE7975039A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
In-Reply-To: <20080306151716.GB25251@ru.mvista.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/4] Emerson KSI8560 base support
Date: Fri, 7 Mar 2008 09:07:17 -0600
References: <20080306151716.GB25251@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 6, 2008, at 9:17 AM, Alexandr Smirnov wrote:

> The KSI8560 is a single compact, mid-, or full-size Advanced =20
> Mezzanine Card
> (AdvancedMC=99) based on the Freescale=99 Semiconductor MPC8560 =20
> PowerQUICC III=99
> microprocessor. This product will serve in data and signaling =20
> applications such
> as signaling gateways (SGW) and softswitch signaling interface cards.
>
> The board has altera maxii CPLD, that is used to obtain and manage =20
> board
> configuration. Also there are two SCC UART serial consoles and FCC =20
> ethernet,
> that is routed to the front panel, while other ethernet controlers =20
> (TSEC's) are
> routed to the backplane.
>
> Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>
>
> arch/powerpc/platforms/85xx/Kconfig   |    7
> arch/powerpc/platforms/85xx/Makefile  |    1
> arch/powerpc/platforms/85xx/ksi8560.c |  257 ++++++++++++++++++++++++=20=

> ++++++++++
> 3 files changed, 265 insertions(+)

applied to powerpc-next.

- k
