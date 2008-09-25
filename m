Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D28DDE7F4
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 05:09:30 +1000 (EST)
Message-ID: <48DBE1E1.6030709@freescale.com>
Date: Thu, 25 Sep 2008 14:09:21 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
References: <1222293567-17694-1-git-send-email-timur@freescale.com>	
	<2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>	
	<48DB9816.4020603@freescale.com>	
	<20080925184020.GA5230@ld0162-tx32.am.freescale.net>
	<ed82fe3e0809251147t30743080v593d194eba731a7b@mail.gmail.com>
	<48DBDFC7.1060907@freescale.com>
In-Reply-To: <48DBDFC7.1060907@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Scott Wood wrote:

>> I chose subsys_initcall() to increase the probability that fsldma is
>> already present when DMA clients are loaded/initialized and register.
> 
> If there's no dependency, why does it matter whether fsldma is already 
> present?

Re-read my explanation, please.  Technically, it doesn't *matter* in that
nothing will break, but so what?  It's nicer if the DMA driver is already
available when the client drivers load, so that they can use the DMA facilities
right away.

-- 
Timur Tabi
Linux kernel developer at Freescale
