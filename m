Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FC7AB7067
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 23:02:34 +1100 (EST)
Date: Fri, 30 Oct 2009 12:02:30 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: mpc512x/clock: fix clk_get logic
Message-ID: <20091030120230.GE717@sirena.org.uk>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
	<20091030105414.GD717@sirena.org.uk>
	<20091030113644.GE12068@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091030113644.GE12068@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 12:36:44PM +0100, Wolfram Sang wrote:
> On Fri, Oct 30, 2009 at 10:54:14AM +0000, Mark Brown wrote:

> > > - require the id field (as _this_ is the unique identifier)

> > NULL id fields are supposed to be supported in the cannonical clkdev
> > API, unfortunately.

> Hmm, ok, thanks for the hint. Where is this documented, I can't find it?

I'm not aware of any particular documentation on it but searching for
mailing list posts from rmk ought to turn up some posts on the issue.
