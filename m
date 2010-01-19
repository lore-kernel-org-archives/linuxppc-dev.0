Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76F63B7C8E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 09:37:34 +1100 (EST)
Date: Tue, 19 Jan 2010 22:16:48 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
Message-ID: <20100119221647.GC29306@sirena.org.uk>
References: <20100119211759.GE3804@infomag.iguana.be>
	<1263937351.18117.69.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1263937351.18117.69.camel@Joe-Laptop.home>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, uclinux-dist-devel@blackfin.uclinux.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 01:42:31PM -0800, Joe Perches wrote:

> Maybe a standard #define WATCHDOG_NAME <foo>

> .identity = WATCHGOD_NAME

I don't really see that the indrection via the #define would buy us
anything?
