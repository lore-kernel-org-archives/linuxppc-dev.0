Return-Path: <wim@iguana.be>
Received: from mailrelay011.isp.belgacom.be (mailrelay011.isp.belgacom.be
	[195.238.6.178]) by ozlabs.org (Postfix) with ESMTP id BE32BB7CF9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 09:00:16 +1100 (EST)
Date: Tue, 19 Jan 2010 23:00:14 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH] watchdog_info separation and constify
Message-ID: <20100119220014.GG3804@infomag.iguana.be>
References: <20100119211759.GE3804@infomag.iguana.be>
	<20100119212755.72e81d24@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100119212755.72e81d24@lxorguk.ukuu.org.uk>
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

Hi Alan,

> > please comment on following patch.
> 
> Why move them out - why not just make them const ?

There's 2 options:
1) we only make them const now. And we move them out later when we do the conversion to the generic watchdog api (which means that we will rip out the code for the open, release, write and ioctl handling of /dev/watchdog) or
2) we make them const and move them out of ioctl and then the ripping out of the code is much easier.

I opted for the second option.

Kind regards,
Wim.
