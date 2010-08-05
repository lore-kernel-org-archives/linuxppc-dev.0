Return-Path: <lgirdwood@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id EA392B6EF1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 22:44:04 +1000 (EST)
Received: by wwe15 with SMTP id 15so1036384wwe.21
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Aug 2010 05:44:02 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] asoc/multi-component: fsl: add support
	for disabled SSI nodes
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20100805114215.GC13146@rakim.wolfsonmicro.main>
References: <1280962268-31407-1-git-send-email-timur@freescale.com>
	<20100805114215.GC13146@rakim.wolfsonmicro.main>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Aug 2010 13:43:59 +0100
Message-ID: <1281012239.3076.112.camel@odin>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-08-05 at 12:42 +0100, Mark Brown wrote:
> On Wed, Aug 04, 2010 at 05:51:08PM -0500, Timur Tabi wrote:
> > Add support for adding "status = disabled" to an SSI node to incidate that it
> > is not wired on the board.  This replaces the not-so-intuitive previous method
> > of omitting a codec-handle property.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
