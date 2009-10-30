Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCE74B7C23
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 22:10:31 +1100 (EST)
Date: Fri, 30 Oct 2009 10:54:14 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: mpc512x/clock: fix clk_get logic
Message-ID: <20091030105414.GD717@sirena.org.uk>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 10:17:14AM +0100, Wolfram Sang wrote:
> The matching logic returns a clock even if only the dev-part matches. This is
> wrong as devices may utilize more than one clock, so the wrong clock may be
> returned due to dev being not unique (noticed while working on the CAN driver).
> The proposed new method will:

> - require the id field (as _this_ is the unique identifier)

NULL id fields are supposed to be supported in the cannonical clkdev
API, unfortunately.
