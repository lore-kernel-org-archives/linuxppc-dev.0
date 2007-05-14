Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 849B6DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 02:17:20 +1000 (EST)
Date: Mon, 14 May 2007 11:16:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Message-ID: <20070514161657.GA371@ld0162-tx32.am.freescale.net>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
	<0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
	<20070510235453.GD27188@localhost.localdomain>
	<b5cd56b7081eaba062cf056545777989@kernel.crashing.org>
	<20070514002457.GD6517@localhost.localdomain>
	<1777f196ba995c48a00d72b94a4dbbd8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1777f196ba995c48a00d72b94a4dbbd8@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 02:33:13PM +0200, Segher Boessenkool wrote:
> My point is that you need a new DTB version to properly
> represent ??.

If we do make a new DTB version, I'd like to see a size field added to
each tag, thus allowing unrecognized tags (or unrecognized extensions to
known tags) to be skipped, thus minimizing the need for new, incompatible
DTB versions in the future.

-Scott
