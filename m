Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C97C1DE001
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:43:59 +1000 (EST)
Date: Wed, 18 Jun 2008 10:43:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
Message-ID: <20080618154338.GA3887@loki.buserror.net>
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
	<20080617195739.GB13147@uranus.ravnborg.org>
	<485818AA.8090701@freescale.com>
	<20080617210055.GA13468@uranus.ravnborg.org>
	<485828B0.4010101@freescale.com>
	<Pine.LNX.4.64.0806171648300.7584@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806171648300.7584@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>, jeff@garzik.org,
	John Rigby <jrigby@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 04:52:25PM -0700, Trent Piepho wrote:
> Why is FS_ENET_HAS_SCC a bool, and not tristate?

That was an oversight on my part -- they should be tristate.

-Scott
