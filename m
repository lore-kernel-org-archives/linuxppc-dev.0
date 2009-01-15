Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71D64DE1CE
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 14:46:12 +1100 (EST)
Message-Id: <533AEE7C-0605-43E9-BB9F-615BE6761202@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Date: Wed, 14 Jan 2009 21:43:50 -0600
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
Cc: Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Xie Xiaobo <X.Xie@freescale.com>, Konjin Lai <Konjin.Lai@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 14, 2009, at 1:46 PM, Anton Vorontsov wrote:

> From: Xie Xiaobo <X.Xie@freescale.com>
>
> This patch adds support for the Freescale Enhanced Secure Digital
> Host Controller Interface as found in some Freescale PowerPC
> microprocessors (e.g. MPC837x SOCs).
>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Signed-off-by: Konjin Lai <Konjin.Lai@freescale.com>
> Signed-off-by: Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/mmc/host/Kconfig  |    9 +
> drivers/mmc/host/Makefile |    1 +
> drivers/mmc/host/esdhc.c  | 1321 ++++++++++++++++++++++++++++++++++++ 
> +++++++++
> drivers/mmc/host/esdhc.h  |  255 +++++++++
> 4 files changed, 1586 insertions(+), 0 deletions(-)
> create mode 100644 drivers/mmc/host/esdhc.c
> create mode 100644 drivers/mmc/host/esdhc.h

Want to work some device tree docs for this.

- k
