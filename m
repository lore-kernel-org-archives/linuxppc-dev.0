Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EF43BDE242
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 00:20:33 +1000 (EST)
Date: Tue, 22 Apr 2008 16:20:24 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
Message-ID: <20080422142024.GA5973@aepfle.de>
References: <47FDEF9B.5000506@semihalf.com>
	<200804151003.17865.jbe@pengutronix.de>
	<200804161324.15887.jbe@pengutronix.de>
	<200804171619.56615.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200804171619.56615.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, Juergen Beisert wrote:

> if someone is interested: Here the full patch to get sound support for
> MPC5200b and a current 2.6.25 kernel.

It misses a 'MODULE_DEVICE_TABLE(of, mpc52xx_ac97_of_match);' and a nul
termination of struct mpc52xx_ac97_of_match.
This will allow autoload of the drivers, as it is done in most other
kernel drivers.

Olaf
