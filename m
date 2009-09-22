Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5DC6B7B6B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 09:53:16 +1000 (EST)
Date: Tue, 22 Sep 2009 16:52:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
Message-Id: <20090922165208.95c814f6.akpm@linux-foundation.org>
In-Reply-To: <1253663027.27055.528.camel@macbook.infradead.org>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
	<200908031954.50955.david-b@pacbell.net>
	<20090922141705.b5d31e24.akpm@linux-foundation.org>
	<20090922230150.GA27593@oksana.dev.rtsoft.ru>
	<1253663027.27055.528.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ben@fluff.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Sep 2009 16:43:47 -0700
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2009-09-23 at 03:01 +0400, Anton Vorontsov wrote:
> > 
> > And the two patches I sent on top:
> > 
> > http://lkml.org/lkml/2009/8/18/364
> > http://lkml.org/lkml/2009/8/18/366
> 
> Got versions of those which apply to the mtd-2.6.git tree (which I'm
> about to ask Linus to pull)? 
> 

I'll send them in a sec.
