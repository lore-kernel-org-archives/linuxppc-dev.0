Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9D7D167A70
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Feb 2005 22:28:38 +1100 (EST)
Date: Sat, 26 Feb 2005 12:28:32 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050226112832.GA10300@suse.de>
References: <1106011958.4533.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1106011958.4533.25.camel@gaston>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Jan 18, Benjamin Herrenschmidt wrote:


> +++ linux-work/arch/ppc/platforms/pmac_cache.S	2005-01-18 12:01:49.000000000 +1100

> +	b	__flush_disable_L1

This one is only available for CONFIG_6xx, so g5 32bit users will
scream. (not that I care)

arch/ppc/platforms/built-in.o(.text+0x1228): In function `flush_disable_caches':
: undefined reference to `__flush_disable_L1'
