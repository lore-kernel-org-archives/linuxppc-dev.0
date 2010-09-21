Return-Path: <timur.tabi@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 2CA69B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:35:03 +1000 (EST)
Received: by qwj9 with SMTP id 9so4926933qwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 15:34:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100921171746.381f2e89@udp111988uds.am.freescale.net>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
	<2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
	<AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
	<20100921171746.381f2e89@udp111988uds.am.freescale.net>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 21 Sep 2010 17:34:28 -0500
Message-ID: <AANLkTinbjb+uQdby999rs1eF1sqPHY2vXJ1mVrznFv=0@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dan Malek <ppc6dev@digitaldans.com>, linuxppc-dev@lists.ozlabs.org,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2010 at 5:17 PM, Scott Wood <scottwood@freescale.com> wrote:

> It needs to be the actual device that is performing the DMA -- the
> platform may need to do things such as IOMMU manipulation where
> knowing the device matters.

Ok, this all makes sense.  So it appears that the patch is valid, at
least in theory.  I would like to see some testing of it, but I
realize that may be too difficult.  There's no easy way to force an
allocation above 4GB.

-- 
Timur Tabi
Linux kernel developer at Freescale
