Return-Path: <SRS0+703ff539752438bf2049+1557+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6CFBDDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:40:00 +1100 (EST)
Subject: Re: [PATCH] MTD: pasemi_nand driver
From: David Woodhouse <dwmw2@infradead.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071128221448.GA1144@lixom.net>
References: <20071128221448.GA1144@lixom.net>
Content-Type: text/plain
Date: Wed, 28 Nov 2007 22:40:32 +0000
Message-Id: <1196289632.27384.0.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-28 at 16:14 -0600, Olof Johansson wrote:
> Plumbing for NAND connected via localbus on PA Semi PWRficient-based
> boards.

Any reason it lacks MODULE_DEVICE_TABLE() ?

I note electra-ide lacks it too. So no autoload of either.

-- 
dwmw2
