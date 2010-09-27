Return-Path: <linus.ml.walleij@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id D5FACB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 01:23:37 +1000 (EST)
Received: by ewy21 with SMTP id 21so1362589ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Sep 2010 08:23:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1285370032-16937-2-git-send-email-iws@ovro.caltech.edu>
References: <1285370032-16937-1-git-send-email-iws@ovro.caltech.edu>
	<1285370032-16937-2-git-send-email-iws@ovro.caltech.edu>
Date: Mon, 27 Sep 2010 17:23:34 +0200
Message-ID: <AANLkTimzdEhAZ=oXbbB3Ge5=YY7OXq3fjaRH4roPNB-k@mail.gmail.com>
Subject: Re: [PATCH RFCv2 1/2] dmaengine: add support for scatterlist to
	scatterlist transfers
From: Linus Walleij <linus.ml.walleij@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Per_Frid=E9n?= <per.friden@stericsson.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/9/25 Ira W. Snyder <iws@ovro.caltech.edu>:

> This adds support for scatterlist to scatterlist DMA transfers.

This is a good idea, we have a local function to do this in DMA40 already,
stedma40_memcpy_sg().

> This is
> currently hidden behind a configuration option, which will allow drivers
> which need this functionality to select it individually.

Why? Isn't it better to add this as a new capability flag
if you don't want to announce it? Or is the intent to save
memory footprint?

Yours,
Linus Walleij
