Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84176DE042
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 06:22:05 +1000 (EST)
Date: Tue, 26 May 2009 21:21:47 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Timur Tabi <timur@freescale.com>
Message-ID: <20090526202146.GA4951@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221509.21370.70182.stgit@terra>
	<20090526110120.GA8969@sirena.org.uk>
	<fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
	<9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
	<ed82fe3e0905261008n68672c6dk7bfc99e4cd614747@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0905261008n68672c6dk7bfc99e4cd614747@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 2/5] Main rewite of the mpc5200 audio
	DMA code
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 12:08:01PM -0500, Timur Tabi wrote:

> It won't be that simple.  V9 of my patch changes the number of
> parameters, so not only will you need to whack this copy of the macro,
> you'll also need to change the callers.

OK, in the interests of cutting down on the amount of review here I've
applied v5 of the series and then marked the AC97 machine drivers as
BROKEN for the time being - once everything lands in mainline we can
make sure that the driver is in sync with the final spin_event_timeout()
API and remove the BROKEN marking.
