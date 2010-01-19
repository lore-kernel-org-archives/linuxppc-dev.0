Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77472B7CF0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 08:53:26 +1100 (EST)
Date: Tue, 19 Jan 2010 21:27:55 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
Message-ID: <20100119212755.72e81d24@lxorguk.ukuu.org.uk>
In-Reply-To: <20100119211759.GE3804@infomag.iguana.be>
References: <20100119211759.GE3804@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	uclinux-dist-devel@blackfin.uclinux.org, Joe Perches <joe@perches.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Jan 2010 22:17:59 +0100
Wim Van Sebroeck <wim@iguana.be> wrote:

> Hi All,
> 
> please comment on following patch.

Why move them out - why not just make them const ?
