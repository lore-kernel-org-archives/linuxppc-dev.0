Return-Path: <BATV+20ed1d84f19b1191780e+2221+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27E20B7B7E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 09:44:19 +1000 (EST)
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
From: David Woodhouse <dwmw2@infradead.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090922230150.GA27593@oksana.dev.rtsoft.ru>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
	<200908031954.50955.david-b@pacbell.net>
	<20090922141705.b5d31e24.akpm@linux-foundation.org>
	<20090922230150.GA27593@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 16:43:47 -0700
Message-Id: <1253663027.27055.528.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: ben@fluff.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, khali@linux-fr.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 03:01 +0400, Anton Vorontsov wrote:
> 
> And the two patches I sent on top:
> 
> http://lkml.org/lkml/2009/8/18/364
> http://lkml.org/lkml/2009/8/18/366

Got versions of those which apply to the mtd-2.6.git tree (which I'm
about to ask Linus to pull)? 

-- 
dwmw2
