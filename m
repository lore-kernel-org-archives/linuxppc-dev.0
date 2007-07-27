Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D604ADDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 16:31:42 +1000 (EST)
In-Reply-To: <20070726131346.GA3417@localhost.localdomain>
References: <20070726131134.GA3309@localhost.localdomain>
	<20070726131346.GA3417@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <250FD11F-9ADC-46CC-B652-1148FC549316@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH 1/4] [POWERPC][SPI] spi_mpc83xx.c:
	should turn off SPI unit	while switching any mode.
Date: Fri, 27 Jul 2007 01:32:27 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2007, at 8:13 AM, Anton Vorontsov wrote:

> Documentation clearly states, that mode should not be changed
> till SPMODE_ENABLE bit set. I've seen hangs w/o this patch.

Out of interest what board/part do you see the hang on?

- k
