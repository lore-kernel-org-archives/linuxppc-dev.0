Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A823DE10A
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 01:47:41 +1000 (EST)
Message-ID: <48E63DB6.8030102@freescale.com>
Date: Fri, 03 Oct 2008 10:43:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable	Kconfig
	option
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
In-Reply-To: <20081003090804.GA29029@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Btw, as for the need.. yes, it was needed to support the FHCI. But
> now the FHCI would just depend on it, which is better approach anyway.

I also noticed that "QE GPIO support" is a top-level Kconfig option, instead of
under Device Drivers -> GPIO.  Is that intentional?

-- 
Timur Tabi
Linux kernel developer at Freescale
