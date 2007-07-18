Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABA22DDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:10:53 +1000 (EST)
Message-ID: <469E3B87.4030901@freescale.com>
Date: Wed, 18 Jul 2007 11:10:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH 22/61] Rename mpc82xx_ads to mpc8272ads.
References: <20070718013527.GT15238@ld0162-tx32.am.freescale.net>
	<1184728051.31656.35.camel@mark>
In-Reply-To: <1184728051.31656.35.camel@mark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Zhan wrote:
> Scott,
> 
> It seems the old name "mpc82xx ads" is still used in your code.
> It will be nice that your file name match your code name, you know, less
> confusion.

See patch 24.

AIUI, it's generally preferred when moving large chunks of code to first 
have a patch that just moves it, and then a subsequent one that makes 
changes.  I was also under the impression that git would generate a one 
line file rename in the diff, but for some reason that didn't happen.

-Scott
