Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8420EDDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 23:55:07 +1000 (EST)
Message-ID: <48DB9816.4020603@freescale.com>
Date: Thu, 25 Sep 2008 08:54:30 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
References: <1222293567-17694-1-git-send-email-timur@freescale.com>
	<2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>
In-Reply-To: <2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang wrote:

>> -subsys_initcall(of_fsl_dma_chan_init);
>>  subsys_initcall(of_fsl_dma_init);
> 
> Not a critical problem.  But module_init() are preferred for modules.

This was intentional.  When compiled as a module, subsys_initcall becomes
module_init().  When compiled in-kernel, this code is initialized before most
drivers, so it's ready when the drivers are loaded.

> Acked-by: Li Yang <leoli@freescale.com>

Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
