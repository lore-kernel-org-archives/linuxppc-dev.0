Return-Path: <SRS0+4fd16b1df69281ce542e+1814+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8611DE102
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 00:56:29 +1000 (EST)
Subject: Re: [RFC 1/3] add support for exporting symbols from .S files
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808111618.08206.arnd@arndb.de>
References: <200808111606.44103.arnd@arndb.de>
	<200808111618.08206.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 15:56:11 +0100
Message-Id: <1218466571.2977.6.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-11 at 16:18 +0200, Arnd Bergmann wrote:
> This makes it possible to export symbols from assembly files, instead
> of having to export them through an extra ksyms.c file.
> 
> I found this nicer to implement using a gas macro than a cpp macro.

Yeah, gas macros can be much nicer. This looks good to me; I don't see
and reason why it can't be used across all architectures, off-hand.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
