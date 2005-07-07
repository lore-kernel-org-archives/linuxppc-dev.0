Return-Path: <SRS0+6a8d017d3a9d31aec255+683+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E11767B96
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 08:10:44 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
In-Reply-To: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA91127964151EC368@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 23:09:18 +0100
Message-Id: <1120774159.3890.294.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: remap_page_range not resolved
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-07-07 at 14:58 -0700, Bizhan Gholikhamseh (bgholikh) wrote:
> I am porting a Linux PCI driver originally developed for X86 platform to
> MPC8540ADS reference  board by Freescale running 2.6 Linux. 
> The "insmod" command fails when I am trying to load the module. The
> failure is because the reference to a function name can not be resolved:
> "remap_page_range"
> Could someone help me please to find out what I am missing from my
> kernel image?

You forgot to include a reference to the source code of the driver
you're having trouble with.

Don't post HTML mail to public fora.

-- 
dwmw2
