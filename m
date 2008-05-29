Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C38C1DDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 21:01:12 +1000 (EST)
Date: Thu, 29 May 2008 11:46:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080529114634.048ea9a0@core>
In-Reply-To: <200805290910.07207.arnd@arndb.de>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<1211926779.3286.104.camel@pasglop>
	<200805290910.07207.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's not exactly a well-established interface. Only five architectures
> define these functions, and there is not a single user in the kernel
> source outside of these architecture's io.h files.

That is because the drivers using them had them removed (eg I=C2=B2O) - mos=
tly
because "it didn't compile on power pc" 8(


Alan
