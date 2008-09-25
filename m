Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAA44DE228
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 05:00:31 +1000 (EST)
Message-ID: <48DBDFC7.1060907@freescale.com>
Date: Thu, 25 Sep 2008 14:00:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
References: <1222293567-17694-1-git-send-email-timur@freescale.com>	
	<2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>	
	<48DB9816.4020603@freescale.com>	
	<20080925184020.GA5230@ld0162-tx32.am.freescale.net>
	<ed82fe3e0809251147t30743080v593d194eba731a7b@mail.gmail.com>
In-Reply-To: <ed82fe3e0809251147t30743080v593d194eba731a7b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	Li Yang <leoli@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> There are no dependencies.  fsldma registers with the DMA engine,
> which is always built in-kernel.  The DMA engine is what handles
> linking DMA clients to DMA drivers. The DMA clients get a callback
> whenever a DMA driver registers with the DMA engine.  If the DMA
> driver is already registered when the client registers, then the
> client will get a callback immediately after it registers.
> 
> I chose subsys_initcall() to increase the probability that fsldma is
> already present when DMA clients are loaded/initialized and register.

If there's no dependency, why does it matter whether fsldma is already 
present?

-Scott
