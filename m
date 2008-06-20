Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9307DDDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 23:12:26 +1000 (EST)
Message-Id: <186FAF55-AA58-418B-A17E-04907BDB7E9C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Chen Gong <g.chen@freescale.com>
In-Reply-To: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] fix mpc83xx spi prescale modulus calculate
Date: Fri, 20 Jun 2008 08:12:09 -0500
References: <1213954697-8569-1-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 20, 2008, at 4:38 AM, Chen Gong wrote:

> Signed-off-by: Chen Gong <g.chen@freescale.com>
> ---
> drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
> 1 files changed, 16 insertions(+), 13 deletions(-)
>

Please CC the SPI devel list.

- k
